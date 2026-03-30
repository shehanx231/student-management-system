<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Registration Successful - ABC Institute</title>
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
    .main{flex:1;padding:60px 0;display:flex;align-items:center;justify-content:center}
    .container{max-width:600px;margin:0 auto;padding:0 24px;width:100%}
    .success-card{
      background:#fff;border-radius:16px;padding:48px 32px;text-align:center;
      box-shadow:0 10px 40px rgba(15,23,42,.08);
      border:1px solid rgba(226,232,240,.8);
    }
    .success-icon{
      font-size:4rem;margin-bottom:24px;
      background:linear-gradient(135deg,#10b981,#059669);
      background-clip:text;-webkit-background-clip:text;
      -webkit-text-fill-color:transparent;
      display:block
    }
    .success-card h2{
      color:#059669;font-size:1.75rem;font-weight:700;margin:0 0 16px;
    }
    .success-card p{
      color:#64748b;font-size:1.1rem;margin:0 0 16px;line-height:1.6
    }
    .success-card .highlight{
      color:#1e293b;font-weight:600;
      background:#f0fdf4;padding:16px;border-radius:12px;
      margin:24px 0;border-left:4px solid #10b981
    }
    .actions{display:flex;gap:16px;justify-content:center;margin-top:32px;flex-wrap:wrap}
    .btn{
      display:inline-flex;align-items:center;gap:8px;
      padding:14px 24px;border-radius:12px;text-decoration:none;
      font-weight:600;font-size:.95rem;transition:all 0.3s ease;
      border:2px solid transparent
    }
    .btn-primary{
      background:linear-gradient(135deg,#3b82f6,#1d4ed8);color:#fff;
    }
    .btn-primary:hover{transform:translateY(-1px);box-shadow:0 8px 25px rgba(59,130,246,.3)}
    .btn-success{
      background:linear-gradient(135deg,#10b981,#059669);color:#fff;
    }
    .btn-success:hover{transform:translateY(-1px);box-shadow:0 8px 25px rgba(16,185,129,.3)}
    footer{
      margin-top:auto;padding:32px 24px;text-align:center;
      color:#64748b;background:#f8fafc;
      border-top:1px solid #e2e8f0
    }
    @media (max-width:768px){
      .nav{padding:14px 16px}
      .nav .links a{margin-left:16px}
      .container{padding:0 16px}
      .main{padding:40px 0}
      .success-card{padding:32px 24px}
      .actions{flex-direction:column}
      .success-card h2{font-size:1.5rem}
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
      <div class="success-card">
        <div class="success-icon">✅</div>
        <h2>Course Registration Successful!</h2>
        <p>Congratulations! You have successfully registered for your selected course.</p>
        <div class="highlight">
          Your course has been added to your academic timetable and you can now access all course materials.
        </div>
        <p>Start your learning journey today and make the most of your educational experience with us.</p>
        <div class="actions">
          <a class="btn btn-primary" href="dashboard.jsp">🏠 Back to Dashboard</a>
          <a class="btn btn-success" href="mycourses.jsp">📚 View My Courses</a>
        </div>
      </div>
    </div>
  </div>
  <footer>&copy; 2025 ABC Institute. All rights reserved.</footer>
</body>
</html>