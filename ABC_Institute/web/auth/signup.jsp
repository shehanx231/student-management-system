<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Sign Up - ABC Institute</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
  <style>
    *{box-sizing:border-box;font-family:Poppins,system-ui,Arial}
    body{
      min-height:100vh; margin:0; display:grid; place-items:center; padding:20px 0;
      background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
    }
    .card{width:min(800px,95vw);background:#fff;border-radius:16px;padding:32px 28px;box-shadow:0 10px 40px rgba(15,23,42,.1);border:1px solid rgba(226,232,240,.8)}
    h2{margin:0 0 20px;color:#0f172a;text-align:center;font-size:1.75rem;font-weight:700}
    .grid{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:16px}
    .grid .full{grid-column:1 / -1}
    label{display:block;font-weight:600;margin:10px 0 6px;color:#334155}
    input,textarea{width:100%;padding:14px 16px;border:2px solid #e2e8f0;border-radius:12px;font-size:.95rem;transition:all 0.3s ease}
    input:focus,textarea:focus{outline:none;border-color:#3b82f6;box-shadow:0 0 0 3px rgba(59,130,246,.1)}
    textarea{min-height:80px;resize:vertical;font-family:inherit}
    .agree{display:flex;gap:12px;align-items:center;margin-top:8px;padding:12px;background:#f8fafc;border-radius:12px;border:1px solid #e2e8f0}
    .agree input[type="checkbox"]{width:auto;margin:0}
    .agree span{color:#334155;font-size:.9rem}
    .btn{margin-top:16px;width:100%;padding:14px 16px;background:linear-gradient(135deg, #10b981, #059669);color:#fff;border:0;border-radius:12px;font-weight:700;cursor:pointer;font-size:1rem;transition:all 0.3s ease}
    .btn:hover{transform:translateY(-1px);box-shadow:0 10px 25px rgba(16,185,129,.3)}
    .error{color:#dc2626;text-align:center;margin-top:12px;font-weight:600;padding:8px 12px;background:rgba(220,38,38,.1);border-radius:8px;border-left:4px solid #dc2626}
    .back-link{text-align:center;margin-top:16px}
    .back-link a{color:#3b82f6;text-decoration:none;font-weight:600;transition:color 0.3s ease}
    .back-link a:hover{color:#1d4ed8}
    @media (max-width: 640px) {
      .grid{grid-template-columns:1fr}
      .card{padding:24px 20px}
    }
  </style>
</head>
<body>
<div class="card">
  <h2>Create your account ✨</h2>
  <form action="<%=request.getContextPath()%>/auth" method="post">
    <input type="hidden" name="action" value="signup">
    <div class="grid">
      <div><label>First Name</label><input type="text" name="first_name" required></div>
      <div><label>Last Name</label><input type="text" name="last_name" required></div>
      <div><label>Date of Birth</label><input type="date" name="dob" required></div>
      <div><label>Phone</label><input type="text" name="phone" required></div>
      <div class="full"><label>Address</label><textarea name="address" required></textarea></div>
      <div><label>Email</label><input type="email" name="email" required></div>
      <div><label>Password</label><input type="password" name="password" required></div>
      <div class="full agree">
        <input type="checkbox" required>
        <span>I agree to the Terms & Conditions and Privacy Policy</span>
      </div>
    </div>
    <button class="btn" type="submit">Create Account</button>
    <div class="back-link">
      <a href="<%=request.getContextPath()%>/auth/login.jsp">← Already have an account? Login</a>
    </div>
    <% if(request.getAttribute("error") != null) { %>
    <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>
  </form>
</div>
</body>
</html>