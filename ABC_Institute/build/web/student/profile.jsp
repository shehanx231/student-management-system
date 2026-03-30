<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.sql.*,util.dbConnect" %>
<%
  if (session.getAttribute("studentId")==null) {
    response.sendRedirect(request.getContextPath()+"/auth/login.jsp");
    return;
  }
  int sid = Integer.parseInt(String.valueOf(session.getAttribute("studentId")));
  String first="", last="", dob="", address="", phone="", email="";
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  try {
    conn = new dbConnect().connect();
    if (conn != null) {
      ps = conn.prepareStatement(
        "SELECT first_name,last_name,dob,address,phone,email FROM student WHERE id=?"
      );
      ps.setInt(1, sid);
      rs = ps.executeQuery();
      if (rs.next()) {
        first = rs.getString("first_name");
        last  = rs.getString("last_name");
        dob   = (rs.getDate("dob") != null) ? rs.getDate("dob").toString() : "";
        address = rs.getString("address");
        phone   = rs.getString("phone");
        email   = rs.getString("email");
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
  <title>My Profile - ABC Institute</title>
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
    .wrap{max-width:900px;margin:0 auto;padding:0 24px}
    .profile-card{
      background:#fff;border-radius:16px;padding:32px;
      box-shadow:0 10px 40px rgba(15,23,42,.08);
      border:1px solid rgba(226,232,240,.8)
    }
    .profile-header{
      text-align:center;margin-bottom:32px;padding-bottom:24px;
      border-bottom:2px solid rgba(226,232,240,.5)
    }
    .profile-header h2{
      margin:0 0 8px;color:#0f172a;font-size:1.75rem;font-weight:700
    }
    .student-index{
      display:inline-block;background:linear-gradient(135deg,#3b82f6,#1d4ed8);
      color:#fff;padding:6px 16px;border-radius:20px;font-size:.9rem;font-weight:600
    }
    .info-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:20px;margin-bottom:32px}
    .info-item{
      background:#f8fafc;border-radius:12px;padding:20px;
      border:1px solid #e2e8f0;transition:all 0.3s ease
    }
    .info-item:hover{background:#f1f5f9;border-color:#cbd5e1}
    .info-label{font-weight:600;color:#334155;margin-bottom:6px;font-size:.9rem;text-transform:uppercase;letter-spacing:.5px}
    .info-value{color:#0f172a;font-size:1.05rem;word-break:break-word}
    .address-item{grid-column:1/-1}
    .actions{display:flex;gap:16px;flex-wrap:wrap;justify-content:center}
    .btn{
      display:inline-flex;align-items:center;gap:8px;
      padding:12px 24px;border-radius:12px;text-decoration:none;
      font-weight:600;font-size:.95rem;transition:all 0.3s ease;
      border:2px solid transparent
    }
    .btn-primary{
      background:linear-gradient(135deg,#10b981,#059669);color:#fff;
    }
    .btn-primary:hover{transform:translateY(-1px);box-shadow:0 8px 25px rgba(16,185,129,.3)}
    .btn-secondary{
      background:linear-gradient(135deg,#3b82f6,#1d4ed8);color:#fff;
    }
    .btn-secondary:hover{transform:translateY(-1px);box-shadow:0 8px 25px rgba(59,130,246,.3)}
    .btn-outline{
      background:transparent;color:#64748b;border-color:#e2e8f0
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
      .profile-card{padding:24px 20px}
      .info-grid{grid-template-columns:1fr}
      .actions{justify-content:stretch}
      .btn{flex:1;justify-content:center}
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
      <div class="profile-card">
        <div class="profile-header">
          <h2><%= first %> <%= last %></h2>
          <span class="student-index">Student ID: <%= String.valueOf(session.getAttribute("studentIndex")) %></span>
        </div>
        <div class="info-grid">
          <div class="info-item">
            <div class="info-label">Date of Birth</div>
            <div class="info-value"><%= dob.isEmpty() ? "Not provided" : dob %></div>
          </div>
          <div class="info-item">
            <div class="info-label">Phone Number</div>
            <div class="info-value"><%= phone %></div>
          </div>
          <div class="info-item">
            <div class="info-label">Email Address</div>
            <div class="info-value"><%= email %></div>
          </div>
          <div class="info-item address-item">
            <div class="info-label">Address</div>
            <div class="info-value"><%= address %></div>
          </div>
        </div>
        <div class="actions">
          <a class="btn btn-primary" href="edit-profile.jsp">✏️ Edit Profile</a>
          <a class="btn btn-secondary" href="change-password.jsp">🔐 Change Password</a>
          <a class="btn btn-outline" href="dashboard.jsp">← Back to Dashboard</a>
        </div>
      </div>
    </div>
  </div>
  <footer>&copy; 2025 ABC Institute. All rights reserved.</footer>
</body>
</html>