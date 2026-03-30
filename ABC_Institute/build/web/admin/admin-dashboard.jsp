<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Admin Dashboard - ABC Institute</title>
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
    .main{flex:1;padding:60px 0;display:flex;align-items:center;justify-content:center}
    .container{max-width:800px;margin:0 auto;padding:0 24px;width:100%}
    .page-header{
      text-align:center;margin-bottom:48px;
    }
    .page-header h2{
      color:#1e293b;font-size:2.5rem;font-weight:700;margin:0 0 12px;
    }
    .page-header p{
      color:#64748b;font-size:1.1rem;margin:0
    }
    .dashboard-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:32px}
    .admin-card{
      background:#fff;border-radius:20px;padding:40px 32px;text-align:center;
      box-shadow:0 10px 40px rgba(15,23,42,.08);
      transition:all 0.3s ease;
      border:1px solid rgba(226,232,240,.8);
      text-decoration:none;
      display:block
    }
    .admin-card:hover{
      transform:translateY(-6px);
      box-shadow:0 25px 60px rgba(15,23,42,.15);
      text-decoration:none
    }
    .admin-card .icon{
      font-size:3.5rem;margin-bottom:20px;display:block
    }
    .admin-card h3{
      color:#1e293b;font-size:1.4rem;font-weight:700;margin:0 0 12px;
      transition:color 0.3s ease
    }
    .admin-card p{
      color:#64748b;font-size:.95rem;margin:0;line-height:1.6
    }
    .admin-card.students{border-left:4px solid #3b82f6}
    .admin-card.students:hover{border-left-color:#1d4ed8}
    .admin-card.students:hover h3{color:#3b82f6}
    .admin-card.students .icon{color:#3b82f6}
    .admin-card.courses{border-left:4px solid #10b981}
    .admin-card.courses:hover{border-left-color:#059669}
    .admin-card.courses:hover h3{color:#10b981}
    .admin-card.courses .icon{color:#10b981}
    footer{
      margin-top:auto;padding:32px 24px;text-align:center;
      color:#64748b;background:#f8fafc;
      border-top:1px solid #e2e8f0
    }
    @media (max-width:768px){
      .nav{padding:14px 16px}
      .container{padding:0 16px}
      .main{padding:40px 0}
      .dashboard-grid{grid-template-columns:1fr;gap:24px}
      .admin-card{padding:32px 24px}
      .page-header h2{font-size:2rem}
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
        <h2>Admin Dashboard</h2>
        <p>Manage students and courses efficiently</p>
      </div>
      <div class="dashboard-grid">
        <a class="admin-card students" href="view-students.jsp">
          <div class="icon">👥</div>
          <h3>Student Management</h3>
          <p>View, search, and manage student details. Change course enrollments and remove students from the system.</p>
        </a>
        <a class="admin-card courses" href="add-course.jsp">
          <div class="icon">📚</div>
          <h3>Course Management</h3>
          <p>Add new courses to the system. Configure course details including name, ID, stream, and descriptions.</p>
        </a>
      </div>
    </div>
  </div>
  <footer>&copy; 2025 ABC Institute. All rights reserved.</footer>
</body>
</html>