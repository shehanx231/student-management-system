<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, util.dbConnect" %>
<%
  if (session.getAttribute("studentId") == null) { 
    response.sendRedirect(request.getContextPath() + "/auth/login.jsp"); 
    return; 
  }
  int sid = Integer.parseInt(session.getAttribute("studentId").toString());
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  try {
    conn = new util.dbConnect().connect();
    ps = conn.prepareStatement(
      "SELECT r.id, r.batch_no, r.created_at, c.course_id, c.course_name " +
      "FROM registration r JOIN course c ON r.course_id = c.course_id " +
      "WHERE r.student_id = ? ORDER BY r.id DESC"
    );
    ps.setInt(1, sid);
    rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>My Courses - ABC Institute</title>
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
    .courses-card{
      background:#fff;border-radius:16px;padding:32px;
      box-shadow:0 10px 40px rgba(15,23,42,.08);
      border:1px solid rgba(226,232,240,.8);
      overflow:hidden
    }
    .table-container{overflow-x:auto}
    .courses-table{width:100%;border-collapse:collapse;margin-bottom:24px}
    .courses-table th{
      background:#f8fafc;
      color:#1e293b;padding:16px;text-align:left;font-weight:600;
      border-bottom:2px solid #e2e8f0;font-size:.9rem;
      text-transform:uppercase;letter-spacing:.5px
    }
    .courses-table td{
      padding:16px;border-bottom:1px solid #f1f5f9;
      transition:background-color 0.3s ease
    }
    .courses-table tbody tr:hover{background:rgba(59,130,246,.02)}
    .course-id{
      font-weight:600;color:#3b82f6;
      background:rgba(59,130,246,.1);padding:4px 8px;
      border-radius:6px;font-size:.85rem;display:inline-block
    }
    .course-name{font-weight:600;color:#1e293b;font-size:1.05rem}
    .batch-no{
      background:linear-gradient(135deg,#10b981,#059669);color:#fff;
      padding:4px 12px;border-radius:12px;font-size:.8rem;font-weight:600
    }
    .enroll-date{color:#64748b;font-size:.9rem}
    .empty-state{
      text-align:center;padding:60px 20px;color:#64748b
    }
    .empty-state-icon{font-size:4rem;margin-bottom:16px;opacity:.6}
    .empty-state h3{margin:0 0 8px;color:#334155;font-size:1.25rem}
    .empty-state p{margin:0 0 24px;font-size:.95rem}
    .btn{
      display:inline-flex;align-items:center;gap:8px;
      padding:12px 24px;border-radius:12px;text-decoration:none;
      font-weight:600;font-size:.95rem;transition:all 0.3s ease;
      border:2px solid transparent
    }
    .btn-primary{
      background:linear-gradient(135deg,#3b82f6,#1d4ed8);color:#fff;
    }
    .btn-primary:hover{transform:translateY(-1px);box-shadow:0 8px 25px rgba(59,130,246,.3)}
    .btn-outline{
      background:transparent;color:#64748b;border-color:#e2e8f0
    }
    .btn-outline:hover{background:#f8fafc;border-color:#cbd5e1;color:#334155}
    .actions{display:flex;gap:16px;justify-content:center;flex-wrap:wrap}
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
      .courses-card{padding:20px 16px}
      .courses-table th,.courses-table td{padding:12px 8px;font-size:.85rem}
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
        <h2>📚 My Enrolled Courses</h2>
        <p>Track your academic journey and course progress</p>
      </div>
      <div class="courses-card">
        <%
        boolean hasData = false;
        %>
        <div class="table-container">
          <table class="courses-table">
            <thead>
              <tr>
                <th>Course ID</th>
                <th>Course Name</th>
                <th>Batch Number</th>
                <th>Enrollment Date</th>
              </tr>
            </thead>
            <tbody>
              <% while (rs.next()) { 
                hasData = true;
              %>
                <tr>
                  <td><span class="course-id"><%= rs.getString("course_id") %></span></td>
                  <td><div class="course-name"><%= rs.getString("course_name") %></div></td>
                  <td><span class="batch-no">Batch <%= rs.getString("batch_no") %></span></td>
                  <td><span class="enroll-date"><%= rs.getString("created_at") %></span></td>
                </tr>
              <% } %>
              <% if (!hasData) { %>
                <tr>
                  <td colspan="4">
                    <div class="empty-state">
                      <div class="empty-state-icon">📖</div>
                      <h3>No Courses Enrolled</h3>
                      <p>You haven't enrolled in any courses yet. Start your learning journey today!</p>
                      <a class="btn btn-primary" href="select-course.jsp">🎯 Browse Courses</a>
                    </div>
                  </td>
                </tr>
              <% } %>
            </tbody>
          </table>
        </div>
        <div class="actions">
          <% if (hasData) { %>
          <a class="btn btn-primary" href="select-course.jsp">➕ Enroll New Course</a>
          <% } %>
          <a class="btn btn-outline" href="dashboard.jsp">← Back to Dashboard</a>
        </div>
      </div>
    </div>
  </div>
  <footer>&copy; 2025 ABC Institute. All rights reserved.</footer>
</body>
</html>
<%
  } catch(Exception e) {
    e.printStackTrace();
%>
<div class="main">
  <div class="container">
    <div class="courses-card">
      <div class="empty-state">
        <div class="empty-state-icon">⚠️</div>
        <h3>Error Loading Courses</h3>
        <p style="color:#dc2626">Unable to load your courses: <%= e.getMessage() %></p>
        <a class="btn btn-outline" href="dashboard.jsp">← Back to Dashboard</a>
      </div>
    </div>
  </div>
</div>
<%
  } finally {
    try { if (rs != null) rs.close(); } catch(Exception ignore){}
    try { if (ps != null) ps.close(); } catch(Exception ignore){}
    try { if (conn != null) conn.close(); } catch(Exception ignore){}
  }
%>