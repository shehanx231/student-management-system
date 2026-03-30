<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  if (session.getAttribute("studentId")==null) {
    response.sendRedirect(request.getContextPath()+"/auth/login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Student Dashboard - ABC Institute</title>
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
    .wrap{max-width:1200px;margin:0 auto;padding:0 24px}
    h2{margin:0 0 12px;color:#1e293b;font-size:2rem;font-weight:700}
    .welcome-desc{margin-bottom:32px;color:#475569;font-size:1rem}
    .grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:24px}
    .card{
      background:#fff;border-radius:16px;padding:28px 24px;text-align:center;
      box-shadow:0 10px 40px rgba(15,23,42,.08);
      transition:all 0.3s ease;
      border:1px solid rgba(226,232,240,.8)
    }
    .card:hover{transform:translateY(-4px);box-shadow:0 20px 60px rgba(15,23,42,.15)}
    .card img{height:80px;margin:0 auto 16px;display:block;opacity:.8;transition:opacity 0.3s ease}
    .card:hover img{opacity:1}
    .card a{font-weight:600;color:#1e293b;text-decoration:none;font-size:1.1rem;transition:color 0.3s ease}
    .card:hover a{color:#3b82f6}
    .card p{margin:8px 0 0;color:#64748b;font-size:.9rem}
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
      .grid{grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:16px}
      h2{font-size:1.5rem}
      .welcome-desc{font-size:.9rem}
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
      <h2>Welcome, <%= String.valueOf(session.getAttribute("studentName")) %>! 👋</h2>
      <p class="welcome-desc">Here you can manage your courses, view your profile, and enroll in new classes. Explore your dashboard to stay updated and keep track of your academic progress.</p>
      <div class="grid">
        <div class="card">
          <img src="../img/1.png" alt="Profile"/>
          <a href="profile.jsp">My Profile</a>
          <p>View and edit your personal information</p>
        </div>
        <div class="card">
          <img src="../img/2.png" alt="My Courses"/>
          <a href="mycourses.jsp">My Courses</a>
          <p>See all your enrolled courses</p>
        </div>
        <div class="card">
          <img src="../img/3.png" alt="Enroll Course"/>
          <a href="select-course.jsp">Enroll Course</a>
          <p>Browse and select new courses</p>
        </div>
        <div class="card">
          <img src="../img/4.png" alt="Course Details"/>
          <a href="course-details.jsp">Course Details</a>
          <p>View detailed course information</p>
        </div>
      </div>
    </div>
  </div>
  <footer>&copy; 2025 ABC Institute. All rights reserved.</footer>
</body>
</html>
