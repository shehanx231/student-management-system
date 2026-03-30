<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  if (session.getAttribute("studentId")==null){ response.sendRedirect(request.getContextPath()+"/auth/login.jsp"); return; }
  int sid = Integer.parseInt(String.valueOf(session.getAttribute("studentId")));
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Change Password - ABC Institute</title>
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
    .main{flex:1;padding:40px 0}
    .wrap{max-width:500px;margin:0 auto;padding:0 24px}
    .form-card{
      background:#fff;border-radius:16px;padding:32px;
      box-shadow:0 10px 40px rgba(15,23,42,.08);
      border:1px solid rgba(226,232,240,.8)
    }
    h2{margin:0 0 24px;color:#0f172a;font-size:1.75rem;font-weight:700;text-align:center}
    .security-icon{text-align:center;margin-bottom:24px;font-size:3rem}
    label{display:block;margin:16px 0 8px;font-weight:600;color:#334155;font-size:.95rem}
    input{
      width:100%;padding:14px 16px;border:2px solid #e2e8f0;border-radius:12px;
      font-size:.95rem;transition:all 0.3s ease
    }
    input:focus{outline:none;border-color:#3b82f6;box-shadow:0 0 0 3px rgba(59,130,246,.1)}
    .btn{
      margin-top:20px;background:linear-gradient(135deg,#3b82f6,#1d4ed8);
      color:#fff;border:0;border-radius:12px;padding:14px 16px;cursor:pointer;
      font-weight:700;font-size:1rem;transition:all 0.3s ease;width:100%
    }
    .btn:hover{transform:translateY(-1px);box-shadow:0 10px 25px rgba(59,130,246,.3)}
    .msg{
      color:#059669;margin-top:12px;font-weight:600;padding:12px 16px;
      background:rgba(5,150,105,.1);border-radius:8px;border-left:4px solid #059669;
      display:none
    }
    .msg.show{display:block}
    .err{
      color:#dc2626;margin-top:12px;font-weight:600;padding:12px 16px;
      background:rgba(220,38,38,.1);border-radius:8px;border-left:4px solid #dc2626;
      display:none
    }
    .err.show{display:block}
    .actions{display:flex;gap:16px;margin-top:24px}
    .btn-outline{
      background:transparent;color:#64748b;border:2px solid #e2e8f0;
      padding:12px 24px;text-decoration:none;border-radius:12px;
      font-weight:600;transition:all 0.3s ease;text-align:center;flex:1
    }
    .btn-outline:hover{background:#f8fafc;border-color:#cbd5e1;color:#334155}
    .password-tips{
      background:#f8fafc;border-radius:12px;padding:16px;
      margin-top:20px;border:1px solid #e2e8f0
    }
    .password-tips h4{margin:0 0 8px;color:#1e293b;font-size:.9rem}
    .password-tips ul{margin:0;padding-left:16px;color:#64748b;font-size:.85rem}
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
        <div class="security-icon">🔐</div>
        <h2>Change Password</h2>
        <form action="<%=request.getContextPath()%>/studentAction" method="post">
          <input type="hidden" name="action" value="changePassword">
          <input type="hidden" name="student_id" value="<%=sid%>">
          <label>Current Password</label>
          <input type="password" name="old_password" required>
          <label>New Password</label>
          <input type="password" name="new_password" required>
          <button class="btn" type="submit">🔄 Update Password</button>
          <div class="actions">
            <a class="btn-outline" href="profile.jsp">← Back to Profile</a>
          </div>
          <% if(request.getParameter("msg") != null && !request.getParameter("msg").isEmpty()) { %>
          <p class="msg show"><%= request.getParameter("msg") %></p>
          <% } %>
          <% if(request.getAttribute("error") != null) { %>
          <p class="err show"><%= request.getAttribute("error") %></p>
          <% } %>
        </form>
        <div class="password-tips">
          <h4>💡 Password Tips:</h4>
          <ul>
            <li>Use at least 8 characters</li>
            <li>Include uppercase and lowercase letters</li>
            <li>Add numbers and special characters</li>
            <li>Avoid common words or personal info</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <footer>&copy; 2025 ABC Institute. All rights reserved.</footer>
</body>
</html>