<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*,util.dbConnect" %>
<%
  if (session.getAttribute("studentId")==null){
    response.sendRedirect(request.getContextPath()+"/auth/login.jsp");
    return;
  }
  int sid = Integer.parseInt(String.valueOf(session.getAttribute("studentId")));
  String first="", last="", dob="", address="", phone="";
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  try {
    conn = new dbConnect().connect();
    if (conn != null) {
      ps = conn.prepareStatement(
        "SELECT first_name,last_name,dob,address,phone FROM student WHERE id=?"
      );
      ps.setInt(1, sid);
      rs = ps.executeQuery();
      if (rs.next()) {
        first = rs.getString("first_name");
        last  = rs.getString("last_name");
        dob   = (rs.getDate("dob") != null) ? rs.getDate("dob").toString() : "";
        address = rs.getString("address");
        phone   = rs.getString("phone");
      }
    }
  } catch(Exception e) {
    e.printStackTrace();
  } finally {
    try { if (rs != null) rs.close(); } catch(Exception ignore) {}
    try { if (ps != null) ps.close(); } catch(Exception ignore) {}
    try { if (conn != null) conn.close(); } catch(Exception ignore) {}
  }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Profile - ABC Institute</title>
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
    .wrap{max-width:800px;margin:0 auto;padding:0 24px}
    .form-card{
      background:#fff;border-radius:16px;padding:32px;
      box-shadow:0 10px 40px rgba(15,23,42,.08);
      border:1px solid rgba(226,232,240,.8)
    }
    h2{margin:0 0 24px;color:#0f172a;font-size:1.75rem;font-weight:700;text-align:center}
    .grid{display:grid;grid-template-columns:repeat(2,1fr);gap:20px}
    .grid .full{grid-column:1/-1}
    label{display:block;margin:12px 0 8px;font-weight:600;color:#334155;font-size:.95rem}
    input,textarea{
      width:100%;padding:14px 16px;border:2px solid #e2e8f0;border-radius:12px;
      font-size:.95rem;transition:all 0.3s ease;font-family:inherit
    }
    input:focus,textarea:focus{outline:none;border-color:#3b82f6;box-shadow:0 0 0 3px rgba(59,130,246,.1)}
    textarea{min-height:100px;resize:vertical}
    .btn{
      margin-top:20px;width:100%;background:linear-gradient(135deg,#10b981,#059669);
      color:#fff;border:0;border-radius:12px;padding:14px 16px;cursor:pointer;
      font-weight:700;font-size:1rem;transition:all 0.3s ease
    }
    .btn:hover{transform:translateY(-1px);box-shadow:0 10px 25px rgba(16,185,129,.3)}
    .actions{display:flex;gap:16px;margin-top:24px}
    .btn-outline{
      background:transparent;color:#64748b;border:2px solid #e2e8f0;
      padding:12px 24px;text-decoration:none;border-radius:12px;
      font-weight:600;transition:all 0.3s ease;text-align:center;flex:1
    }
    .btn-outline:hover{background:#f8fafc;border-color:#cbd5e1;color:#334155}
    footer{
      margin-top:auto;padding:32px 24px;text-align:center;
      color:#64748b;background:#f8fafc;
      border-top:1px solid #e2e8f0
    }
    @media (max-width:768px){
      .nav{padding:14px 16px}
      .nav .links a{margin-left:16px}
      .wrap{padding:0 16px}
      .main{padding:24px 0}
      .form-card{padding:24px 20px}
      .grid{grid-template-columns:1fr}
      .actions{flex-direction:column}
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
    <div class="wrap">
      <div class="form-card">
        <h2>✏️ Edit Profile</h2>
        <form action="<%=request.getContextPath()%>/studentAction" method="post">
          <input type="hidden" name="action" value="updateProfile">
          <input type="hidden" name="student_id" value="<%=sid%>">
          <div class="grid">
            <div><label>First Name</label><input name="first_name" value="<%=first%>" required></div>
            <div><label>Last Name</label><input name="last_name" value="<%=last%>" required></div>
            <div><label>Date of Birth</label><input type="date" name="dob" value="<%=dob%>" required></div>
            <div><label>Phone Number</label><input name="phone" value="<%=phone%>" required></div>
            <div class="full"><label>Address</label><textarea name="address" required><%=address%></textarea></div>
          </div>
          <button class="btn" type="submit">💾 Save Changes</button>
          <div class="actions">
            <a class="btn-outline" href="profile.jsp">← Cancel</a>
          </div>
        </form>
      </div>
    </div>
  </div>
  <footer>&copy; 2025 ABC Institute. All rights reserved.</footer>
</body>
</html>