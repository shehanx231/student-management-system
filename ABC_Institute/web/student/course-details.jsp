<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, util.dbConnect" %>
<%
  Connection conn = new util.dbConnect().connect();
  Statement st = conn.createStatement();
  ResultSet rs = st.executeQuery("SELECT * FROM course ORDER BY stream, course_name");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Course Details - ABC Institute</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
  <style>
    *{box-sizing:border-box;font-family:Poppins,system-ui,Arial}
    body{
      margin:0;
      background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
      color:#0f172a;
      min-height:100vh;
      display:flex;
      flex-direction:column;
    }
    .nav{
      background:#0f172a;color:#fff;padding:16px 24px;
      display:flex;justify-content:space-between;align-items:center;
      box-shadow:0 4px 20px rgba(0,0,0,.1)
    }
    .nav .brand{font-size:1.25rem;font-weight:700;color:#fff;text-decoration:none}
    .nav .links a{color:rgba(255,255,255,.9);text-decoration:none;margin-left:24px;font-weight:500;transition:all 0.3s ease;padding:6px 12px;border-radius:8px}
    .nav .links a:hover{color:#fff;background:rgba(255,255,255,.1)}
    .main{flex:1;padding:32px 0}
    .container{max-width:1200px;margin:0 auto;padding:0 24px}
    .page-header{
      text-align:center;margin-bottom:40px;
    }
    .page-header h2{
      color:#1e293b;font-size:2rem;font-weight:700;margin:0 0 8px;
    }
    .page-header p{
      color:#64748b;font-size:1.1rem;margin:0
    }
    .courses-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(350px,1fr));gap:24px;margin-bottom:40px}
    .course-card{
      background:#fff;border-radius:16px;padding:28px;
      box-shadow:0 10px 40px rgba(15,23,42,.08);
      transition:all 0.3s ease;
      border:1px solid rgba(226,232,240,.8);
      height:fit-content
    }
    .course-card:hover{transform:translateY(-4px);box-shadow:0 20px 60px rgba(15,23,42,.15)}
    .course-header{display:flex;align-items:flex-start;justify-content:space-between;margin-bottom:16px}
    .course-card h3{
      color:#1e293b;font-size:1.25rem;font-weight:700;margin:0;
      line-height:1.4;flex:1;margin-right:12px
    }
    .course-id{
      background:linear-gradient(135deg,#3b82f6,#1d4ed8);color:#fff;
      padding:4px 12px;border-radius:20px;font-size:.8rem;font-weight:600;
      white-space:nowrap
    }
    .stream-badge{
      display:inline-block;background:#f1f5f9;color:#475569;
      padding:6px 12px;border-radius:8px;font-size:.85rem;font-weight:600;
      margin-bottom:16px;border:1px solid #e2e8f0
    }
    .course-description{
      color:#64748b;font-size:.95rem;line-height:1.6;margin:0
    }
    .no-description{
      color:#94a3b8;font-style:italic
    }
    .back-section{
      text-align:center;padding:40px 0 20px
    }
    .btn{
      display:inline-flex;align-items:center;gap:8px;
      padding:14px 24px;border-radius:12px;text-decoration:none;
      font-weight:600;font-size:.95rem;transition:all 0.3s ease;
      border:2px solid transparent
    }
    .btn-outline{
      background:transparent;color:#64748b;border-color:#e2e8f0
    }
    .btn-outline:hover{background:#f8fafc;border-color:#cbd5e1;color:#334155;transform:translateY(-1px)}
    .empty-state{
      text-align:center;padding:80px 20px;color:#64748b
    }
    .empty-state-icon{font-size:4rem;margin-bottom:16px;opacity:.6}
    .empty-state h3{margin:0 0 8px;color:#334155;font-size:1.25rem}
    .empty-state p{margin:0;font-size:.95rem}
    footer{
      margin-top:auto;padding:32px 24px;text-align:center;
      color:#64748b;background:#f8fafc;
      border-top:1px solid #e2e8f0
    }
    @media (max-width:768px){
      .nav{padding:14px 16px}
      .nav .links a{margin-left:16px}
      .container{padding:0 16px}
      .main{padding:24px 0}
      .courses-grid{grid-template-columns:1fr;gap:16px}
      .course-card{padding:20px}
      .course-header{flex-direction:column;gap:12px}
      .course-card h3{margin-right:0}
      .page-header h2{font-size:1.5rem}
    }
  </style>
</head>
<body>
  <div class="nav">
    <a href="dashboard.jsp" class="brand">🎓 ABC Institute</a>
    <div class="links">
      <a href="<%=request.getContextPath()%>/about.jsp">About</a>
      <a href="<%=request.getContextPath()%>/contact.jsp">Contact</a>
      <a href="<%=request.getContextPath()%>/logout">Logout</a>
    </div>
  </div>
  <div class="main">
    <div class="container">
      <div class="page-header">
        <h2>📖 Course Details</h2>
        <p>Explore our comprehensive course catalog</p>
      </div>
      <div class="courses-grid">
        <%
        boolean hasData = false;
        while (rs.next()) { 
          hasData = true;
        %>
          <div class="course-card">
            <div class="course-header">
              <h3><%= rs.getString("course_name") %></h3>
              <span class="course-id"><%= rs.getString("course_id") %></span>
            </div>
            <div class="stream-badge">🎯 <%= rs.getString("stream") %></div>
            <p class="course-description <%= rs.getString("description")==null||rs.getString("description").trim().isEmpty()?"no-description":"" %>">
              <%= rs.getString("description")==null||rs.getString("description").trim().isEmpty()?"No description available for this course.":rs.getString("description") %>
            </p>
          </div>
        <% } 
        if (!hasData) { %>
          <div class="empty-state" style="grid-column:1/-1">
            <div class="empty-state-icon">📚</div>
            <h3>No Courses Available</h3>
            <p>There are currently no courses in our catalog. Please check back later.</p>
          </div>
        <% } %>
      </div>
      <div class="back-section">
        <a class="btn btn-outline" href="dashboard.jsp">← Back to Dashboard</a>
      </div>
    </div>
  </div>
  <footer>&copy; 2025 ABC Institute. All rights reserved.</footer>
</body>
</html>
<% rs.close(); st.close(); conn.close(); %>