<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, util.dbConnect, java.util.*" %>
<%
  if (session.getAttribute("admin") == null) {
    response.sendRedirect(request.getContextPath()+"/auth/login.jsp");
    return;
  }

  String searchId = request.getParameter("searchId");  // index number entered by admin

  Connection conn = null;
  PreparedStatement pst = null;
  ResultSet rs = null;
  Statement cs = null;
  ResultSet courses = null;
  Map<String,String> courseMap = new LinkedHashMap<String,String>();

  try {
    conn = new dbConnect().connect();

    String sql =
      "SELECT s.id AS student_id, s.index_no, CONCAT(s.first_name,' ',s.last_name) AS sname, s.email AS semail, " +
      "r.id AS registration_id, c.course_id, c.course_name AS cname " +
      "FROM student s " +
      "LEFT JOIN registration r ON s.id=r.student_id " +
      "LEFT JOIN course c ON r.course_id=c.course_id ";

    if (searchId != null && !searchId.trim().isEmpty()) {
      sql += "WHERE s.index_no = ? ";
    }

    sql += "ORDER BY s.id DESC";

    if (searchId != null && !searchId.trim().isEmpty()) {
      pst = conn.prepareStatement(sql);
      pst.setInt(1, Integer.parseInt(searchId));
      rs = pst.executeQuery();
    } else {
      pst = conn.prepareStatement(sql);
      rs = pst.executeQuery();
    }

    cs = conn.createStatement();
    courses = cs.executeQuery("SELECT course_id, course_name FROM course ORDER BY course_name");
    while (courses.next()) {
      courseMap.put(courses.getString("course_id"), courses.getString("course_name"));
    }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>View Students - Admin</title>
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
    .nav .logout{
      background:transparent;color:rgba(255,255,255,.9);border:1px solid rgba(255,255,255,.3);
      padding:8px 16px;border-radius:8px;text-decoration:none;font-size:.9rem;
      transition:all 0.3s ease
    }
    .nav .logout:hover{background:rgba(255,255,255,.1);color:#fff;border-color:rgba(255,255,255,.5)}
    .main{flex:1;padding:32px 0}
    .container{max-width:1400px;margin:0 auto;padding:0 24px}
    .page-header{
      text-align:center;margin-bottom:32px;
    }
    .page-header h2{
      color:#1e293b;font-size:2rem;font-weight:700;margin:0 0 8px;
    }
    .page-header p{
      color:#64748b;font-size:1.1rem;margin:0
    }
    .search-card{
      background:#fff;border-radius:16px;padding:24px;
      box-shadow:0 6px 30px rgba(15,23,42,.06);
      border:1px solid rgba(226,232,240,.8);
      margin-bottom:24px
    }
    .search-form{display:flex;gap:12px;align-items:end;flex-wrap:wrap}
    .search-group{flex:1;min-width:200px}
    .search-group label{display:block;margin:0 0 6px;font-weight:600;color:#334155;font-size:.9rem}
    .search-group input{
      width:100%;padding:12px 16px;border:2px solid #e2e8f0;border-radius:10px;
      font-size:.95rem;transition:all 0.3s ease
    }
    .search-group input:focus{outline:none;border-color:#3b82f6;box-shadow:0 0 0 3px rgba(59,130,246,.1)}
    .search-actions{display:flex;gap:8px}
    .btn{
      display:inline-flex;align-items:center;gap:6px;
      padding:12px 20px;border-radius:10px;text-decoration:none;
      font-weight:600;font-size:.9rem;transition:all 0.3s ease;
      border:2px solid transparent;cursor:pointer;white-space:nowrap
    }
    .btn-primary{
      background:linear-gradient(135deg,#3b82f6,#1d4ed8);color:#fff;border:0
    }
    .btn-primary:hover{transform:translateY(-1px);box-shadow:0 6px 20px rgba(59,130,246,.3)}
    .btn-secondary{
      background:#64748b;color:#fff;border:0
    }
    .btn-secondary:hover{background:#475569;transform:translateY(-1px)}
    .btn-outline{
      background:transparent;color:#64748b;border-color:#e2e8f0
    }
    .btn-outline:hover{background:#f8fafc;border-color:#cbd5e1;color:#334155}
    .data-card{
      background:#fff;border-radius:16px;
      box-shadow:0 6px 30px rgba(15,23,42,.06);
      border:1px solid rgba(226,232,240,.8);
      overflow:hidden
    }
    .table-container{overflow-x:auto}
    .students-table{width:100%;border-collapse:collapse}
    .students-table th{
      background:#f8fafc;color:#1e293b;padding:16px;text-align:left;font-weight:600;
      border-bottom:2px solid #e2e8f0;font-size:.9rem;
      text-transform:uppercase;letter-spacing:.5px
    }
    .students-table td{
      padding:16px;border-bottom:1px solid #f1f5f9;
      transition:background-color 0.3s ease;vertical-align:top
    }
    .students-table tbody tr:hover{background:rgba(59,130,246,.02)}
    .student-name{font-weight:600;color:#1e293b;font-size:1.05rem}
    .student-index{
      background:linear-gradient(135deg,#3b82f6,#1d4ed8);color:#fff;
      padding:4px 10px;border-radius:12px;font-size:.8rem;font-weight:600;
      display:inline-block
    }
    .student-email{color:#64748b;font-size:.9rem}
    .course-info{
      display:flex;flex-direction:column;gap:4px
    }
    .course-id{
      background:#f0f9ff;color:#0369a1;
      padding:3px 8px;border-radius:6px;font-size:.8rem;font-weight:600;
      display:inline-block;width:fit-content
    }
    .course-name{color:#1e293b;font-size:.9rem}
    .no-course{color:#94a3b8;font-style:italic;font-size:.9rem}
    .actions-cell{white-space:nowrap}
    .course-change-form{display:flex;gap:8px;align-items:center;margin-bottom:8px}
    .course-select{
      padding:6px 10px;border:1px solid #e2e8f0;border-radius:8px;
      font-size:.8rem;min-width:120px
    }
    .btn-sm{padding:6px 12px;font-size:.8rem}
    .btn-change{background:linear-gradient(135deg,#10b981,#059669);color:#fff;border:0}
    .btn-change:hover{box-shadow:0 4px 15px rgba(16,185,129,.3)}
    .btn-danger{background:linear-gradient(135deg,#ef4444,#dc2626);color:#fff;border:0}
    .btn-danger:hover{box-shadow:0 4px 15px rgba(239,68,68,.3)}
    .empty-state{
      text-align:center;padding:60px 20px;color:#64748b
    }
    .empty-state-icon{font-size:3rem;margin-bottom:16px;opacity:.6}
    .empty-state h3{margin:0 0 8px;color:#334155;font-size:1.25rem}
    .empty-state p{margin:0;font-size:.95rem}
    .back-section{
      text-align:center;padding:24px;background:#f8fafc;
      border-top:1px solid #e2e8f0
    }
    footer{
      margin-top:auto;padding:32px 24px;text-align:center;
      color:#64748b;background:#f8fafc;
      border-top:1px solid #e2e8f0
    }
    @media (max-width:768px){
      .nav{padding:14px 16px}
      .container{padding:0 16px}
      .main{padding:24px 0}
      .search-form{flex-direction:column}
      .search-group{min-width:100%}
      .search-actions{justify-content:stretch}
      .btn{justify-content:center}
      .students-table th,.students-table td{padding:12px 8px;font-size:.85rem}
      .course-change-form{flex-direction:column;gap:6px}
      .course-select{min-width:100%}
    }
  </style>
</head>
<body>
  <div class="nav">
    <div class="brand">🛠️ ABC Institute - Admin Dashboard</div>
    <a class="logout" href="<%=request.getContextPath()%>/logout">Logout</a>
  </div>
  <div class="main">
    <div class="container">
      <div class="page-header">
        <h2>👥 Student Management</h2>
        <p>View and manage student details and course enrollments</p>
      </div>

      <!-- Search Form -->
      <div class="search-card">
        <form class="search-form" method="get" action="view-students.jsp">
          <div class="search-group">
            <label>🔍 Search by Student Index Number</label>
            <input type="number" name="searchId" placeholder="Enter student index number" value="<%= searchId==null?"":searchId %>">
          </div>
          <div class="search-actions">
            <button class="btn btn-primary" type="submit">Search</button>
            <a href="view-students.jsp" class="btn btn-secondary">Reset</a>
          </div>
        </form>
      </div>

      <div class="data-card">
        <div class="table-container">
          <table class="students-table">
            <thead>
              <tr>
                <th>Student Details</th>
                <th>Index Number</th>
                <th>Email</th>
                <th>Course Enrollment</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <%
                boolean hasData = false;
                while (rs.next()) {
                  hasData = true;
              %>
              <tr>
                <td>
                  <div class="student-name"><%= rs.getString("sname") %></div>
                </td>
                <td>
                  <span class="student-index"><%= rs.getInt("index_no") %></span>
                </td>
                <td>
                  <div class="student-email"><%= rs.getString("semail") %></div>
                </td>
                <td>
                  <%
                    String cid = rs.getString("course_id");
                    String cname = rs.getString("cname");
                  %>
                  <% if (cid != null) { %>
                    <div class="course-info">
                      <span class="course-id"><%= cid %></span>
                      <div class="course-name"><%= cname %></div>
                    </div>
                  <% } else { %>
                    <div class="no-course">No course enrolled</div>
                  <% } %>
                </td>
                <td class="actions-cell">
                  <% if (cid != null) { %>
                  <form action="<%=request.getContextPath()%>/adminAction" method="post" class="course-change-form">
                    <input type="hidden" name="action" value="changeStudentCourse">
                    <input type="hidden" name="registration_id" value="<%= rs.getInt("registration_id") %>">
                    <select name="new_course_id" class="course-select">
                      <% for (Map.Entry<String,String> e : courseMap.entrySet()) { %>
                        <option value="<%= e.getKey() %>" <%= e.getKey().equals(cid)?"selected":"" %>>
                          <%= e.getKey() %> - <%= e.getValue() %>
                        </option>
                      <% } %>
                    </select>
                    <button class="btn btn-sm btn-change">Change</button>
                  </form>
                  <% } %>
                  <form action="<%=request.getContextPath()%>/adminAction" method="post" class="d-inline" onsubmit="return confirm('Are you sure you want to remove this student? This action cannot be undone.');">
                    <input type="hidden" name="action" value="removeStudent">
                    <input type="hidden" name="student_id" value="<%= rs.getInt("student_id") %>">
                    <button class="btn btn-sm btn-danger">🗑️ Remove</button>
                  </form>
                </td>
              </tr>
              <% } 
              if (!hasData) { %>
                <tr>
                  <td colspan="5">
                    <div class="empty-state">
                      <div class="empty-state-icon">👤</div>
                      <h3>No Students Found</h3>
                      <p><%= searchId != null ? "No student found with index number: " + searchId : "No students are currently registered in the system." %></p>
                    </div>
                  </td>
                </tr>
              <% } %>
            </tbody>
          </table>
        </div>
        <div class="back-section">
          <a class="btn btn-outline" href="admin-dashboard.jsp">← Back to Admin Dashboard</a>
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
  } finally {
    try { if (rs != null) rs.close(); } catch(Exception ignore){}
    try { if (pst != null) pst.close(); } catch(Exception ignore){}
    try { if (courses != null) courses.close(); } catch(Exception ignore){}
    try { if (cs != null) cs.close(); } catch(Exception ignore){}
    try { if (conn != null) conn.close(); } catch(Exception ignore){}
  }
%>