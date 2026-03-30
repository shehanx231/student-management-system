<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, util.dbConnect" %>
<%
  if (session.getAttribute("studentId")==null) { 
    response.sendRedirect(request.getContextPath()+"/auth/login.jsp"); 
    return; 
  }

  int sid = Integer.parseInt(session.getAttribute("studentId").toString());

  Connection c = null;
  PreparedStatement s = null;
  ResultSet rs = null;
  Statement cs = null;
  ResultSet all = null;

  int indexNo = 0;
  String nm = "";
  String em = "";

  try {
    c = new util.dbConnect().connect();
    s = c.prepareStatement("SELECT index_no, CONCAT(first_name,' ',last_name) AS nm, email FROM student WHERE id=?");
    s.setInt(1, sid);
    rs = s.executeQuery();
    if (rs.next()) {
      indexNo = rs.getInt("index_no");
      nm = rs.getString("nm");
      em = rs.getString("email");
    }

    cs = c.createStatement();
    all = cs.executeQuery("SELECT course_id, course_name, stream FROM course ORDER BY course_name");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Select Course - ABC Institute</title>
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
    .container{max-width:900px;margin:0 auto;padding:0 24px}
    .page-header{
      text-align:center;margin-bottom:40px;
    }
    .page-header h2{
      color:#1e293b;font-size:2rem;font-weight:700;margin:0 0 8px;
    }
    .page-header p{
      color:#64748b;font-size:1.1rem;margin:0
    }
    .form-card{
      background:#fff;border-radius:16px;padding:32px;
      box-shadow:0 10px 40px rgba(15,23,42,.08);
      border:1px solid rgba(226,232,240,.8);
    }
    .form-grid{display:grid;grid-template-columns:repeat(2,1fr);gap:20px}
    .form-grid .full{grid-column:1/-1}
    .form-group{margin-bottom:20px}
    label{display:block;margin:0 0 8px;font-weight:600;color:#334155;font-size:.95rem}
    input,select{
      width:100%;padding:14px 16px;border:2px solid #e2e8f0;border-radius:12px;
      font-size:.95rem;transition:all 0.3s ease;font-family:inherit
    }
    input:focus,select:focus{outline:none;border-color:#3b82f6;box-shadow:0 0 0 3px rgba(59,130,246,.1)}
    input[readonly]{background:#f8fafc;color:#64748b}
    select option{padding:8px}
    .checkbox-group{
      display:flex;gap:12px;align-items:center;margin-top:16px;padding:16px;
      background:#f8fafc;border-radius:12px;border:1px solid #e2e8f0
    }
    .checkbox-group input[type="checkbox"]{width:auto;margin:0}
    .checkbox-group label{margin:0;color:#334155;font-size:.9rem;font-weight:500}
    .actions{display:flex;gap:16px;margin-top:24px;justify-content:center}
    .btn{
      display:inline-flex;align-items:center;gap:8px;
      padding:14px 24px;border-radius:12px;text-decoration:none;
      font-weight:600;font-size:.95rem;transition:all 0.3s ease;
      border:2px solid transparent;cursor:pointer
    }
    .btn-primary{
      background:linear-gradient(135deg,#10b981,#059669);color:#fff;border:0
    }
    .btn-primary:hover{transform:translateY(-1px);box-shadow:0 8px 25px rgba(16,185,129,.3)}
    .btn-outline{
      background:transparent;color:#64748b;border-color:#e2e8f0
    }
    .btn-outline:hover{background:#f8fafc;border-color:#cbd5e1;color:#334155}
    .error-msg{
      color:#dc2626;text-align:center;margin-top:12px;font-weight:600;
      padding:12px 16px;background:rgba(220,38,38,.1);border-radius:8px;
      border-left:4px solid #dc2626;display:none
    }
    .error-msg.show{display:block}
    .muted{color:#64748b;font-size:.85rem}
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
      .form-card{padding:24px 20px}
      .form-grid{grid-template-columns:1fr}
      .actions{flex-direction:column}
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
        <h2>📚 Course Registration</h2>
        <p>Select and enroll in your desired course</p>
      </div>
      <div class="form-card">
        <form action="<%=request.getContextPath()%>/studentAction" method="post">
          <input type="hidden" name="action" value="selectCourse">
          <input type="hidden" name="student_id" value="<%= sid %>">

          <div class="form-grid">
            <div class="form-group">
              <label>Full Name</label>
              <input name="full_name" value="<%= nm %>" readonly>
            </div>
            <div class="form-group">
              <label>Student Index</label>
              <input value="<%= indexNo %>" readonly>
            </div>
            <div class="form-group">
              <label>Email Address</label>
              <input name="email" value="<%= em %>" readonly>
            </div>
            <div class="form-group">
              <label>Batch Number</label>
              <input name="batch_no" placeholder="e.g. 24.1" required>
              <small class="muted">Enter your batch number (e.g. 24.1 for 2024 batch 1)</small>
            </div>
            <div class="form-group full">
              <label>Select Course</label>
              <select id="courseSelect" required>
                <option value="">-- Select a course --</option>
                <%
                  while (all.next()) {
                    String cid = all.getString("course_id");
                    String cname = all.getString("course_name");
                    String stream = all.getString("stream");
                %>
                  <option value="<%= cid %>" data-stream="<%= stream %>" data-name="<%= cname %>">
                    <%= cname %> — <span class="muted"><%= stream %></span>
                  </option>
                <% } %>
              </select>
            </div>
            <div class="form-group">
              <label>Course ID <span class="muted">(auto-filled)</span></label>
              <input id="courseId" name="course_id" readonly required>
            </div>
          </div>

          <!-- Hidden inputs for stream and course name -->
          <input type="hidden" id="courseStream" name="stream">
          <input type="hidden" id="courseName" name="course_name">

          <div class="checkbox-group">
            <input id="agree" type="checkbox" required>
            <label for="agree">I agree to the terms & conditions and course requirements</label>
          </div>

          <div class="actions">
            <button class="btn btn-primary" type="submit">✅ Submit Registration</button>
            <a class="btn btn-outline" href="dashboard.jsp">← Back to Dashboard</a>
          </div>

          <% if(request.getAttribute("msg") != null) { %>
          <p class="error-msg show"><%= request.getAttribute("msg") %></p>
          <% } %>
        </form>
      </div>
    </div>
  </div>
  <footer>&copy; 2025 ABC Institute. All rights reserved.</footer>

  <script>
    const sel = document.getElementById('courseSelect');
    const cid = document.getElementById('courseId');
    const cstream = document.getElementById('courseStream');
    const cname = document.getElementById('courseName');

    sel.addEventListener('change', () => {
      const selectedOption = sel.options[sel.selectedIndex];
      cid.value = selectedOption.value || "";
      cstream.value = selectedOption.getAttribute('data-stream') || "";
      cname.value = selectedOption.getAttribute('data-name') || "";
    });
  </script>
</body>
</html>
<%
  } finally {
    try { if (all!=null) all.close(); } catch(Exception ignore){}
    try { if (cs!=null) cs.close(); } catch(Exception ignore){}
    try { if (rs!=null) rs.close(); } catch(Exception ignore){}
    try { if (s!=null) s.close(); } catch(Exception ignore){}
    try { if (c!=null) c.close(); } catch(Exception ignore){}
  }
%>