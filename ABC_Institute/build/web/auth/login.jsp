<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login - ABC Institute</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
  <style>
    *{box-sizing:border-box;font-family:Poppins,system-ui,Arial}
    body{
      min-height:100vh; margin:0; display:grid; place-items:center;
      background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
    }
    .card{width:min(420px,92vw); background:#fff; border-radius:16px; padding:32px 28px; box-shadow:0 10px 40px rgba(15,23,42,.1); border:1px solid rgba(226,232,240,.8)}
    h2{margin:0 0 8px; color:#0f172a; font-size:1.75rem; font-weight:700}
    .muted{color:#64748b; font-size:.9rem; margin-bottom:24px}
    label{display:block; font-weight:600; margin:14px 0 6px; color:#334155}
    input{width:100%; padding:14px 16px; border:2px solid #e2e8f0; border-radius:12px; font-size:.95rem; transition:all 0.3s ease}
    input:focus{outline:none; border-color:#3b82f6; box-shadow:0 0 0 3px rgba(59,130,246,.1)}
    .btn{margin-top:20px; width:100%; padding:14px 16px; background:linear-gradient(135deg, #3b82f6, #1d4ed8); color:#fff; border:0; border-radius:12px; font-weight:700; cursor:pointer; font-size:1rem; transition:all 0.3s ease}
    .btn:hover{transform:translateY(-1px); box-shadow:0 10px 25px rgba(59,130,246,.3)}
    .alt{margin-top:16px; text-align:center; color:#64748b}
    .alt a{color:#3b82f6; text-decoration:none; font-weight:600; transition:color 0.3s ease}
    .alt a:hover{color:#1d4ed8}
    .err{margin-top:12px; color:#dc2626; font-weight:600; padding:8px 12px; background:rgba(220,38,38,.1); border-radius:8px; border-left:4px solid #dc2626}
  </style>
</head>
<body>
<div class="card">
  <h2>Welcome back 👋</h2>
  <p class="muted">Log in to your student or admin account</p>
  <form action="<%=request.getContextPath()%>/auth" method="post">
    <input type="hidden" name="action" value="login">
    <label>Email</label>
    <input type="email" name="email" required>
    <label>Password</label>
    <input type="password" name="password" required>
    <button class="btn" type="submit">Login</button>
    <p class="alt">Don't have an account? <a href="<%=request.getContextPath()%>/auth/signup.jsp">Sign up</a></p>
    <% if(request.getAttribute("error") != null) { %>
    <p class="err"><%= request.getAttribute("error") %></p>
    <% } %>
  </form>
</div>
</body>
</html>