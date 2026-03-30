<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Add Course - ABC Institute</title>
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
    .main{flex:1;padding:40px 0}
    .container{max-width:800px;margin:0 auto;padding:0 24px}
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
    .form-grid{display:grid;grid-template-columns:1fr 2fr;gap:20px;align-items:start}
    .form-grid.full{grid-template-columns:1fr}
    .form-group{margin-bottom:20px}
    label{display:block;margin:0 0 8px;font-weight:600;color:#334155;font-size:.95rem}
    input,textarea{
      width:100%;padding:14px 16px;border:2px solid #e2e8f0;border-radius:12px;
      font-size:.95rem;transition:all 0.3s ease;font-family:inherit
    }
    input:focus,textarea:focus{outline:none;border-color:#3b82f6;box-shadow:0 0 0 3px rgba(59,130,246,.1)}
    textarea{min-height:100px;resize:vertical}
    .form-hint{color:#64748b;font-size:.85rem;margin-top:4px}
    .actions{display:flex;gap:16px;margin-top:32px;justify-content:center}
    .btn{
      display:inline-flex;align-items:center;gap:8px;
      padding:14px 24px;border-radius:12px;text-decoration:none;
      font-weight:600;font-size:.95rem;transition:all 0.3s ease;
      border:2px solid transparent;cursor:pointer
    }
    .btn-success{
      background:linear-gradient(135deg,#10b981,#059669);color:#fff;border:0
    }
    .btn-success:hover{transform:translateY(-1px);box-shadow:0 8px 25px rgba(16,185,129,.3)}
    .btn-outline{
      background:transparent;color:#64748b;border-color:#e2e8f0
    }
    .btn-outline:hover{background:#f8fafc;border-color:#cbd5e1;color:#334155}
    .success-msg{
      color:#059669;text-align:center;margin-top:16px;font-weight:600;
      padding:12px 16px;background:rgba(5,150,105,.1);border-radius:8px;
      border-left:4px solid #059669;display:none
    }
    .success-msg.show{display:block}
    .course-preview{
      background:#f8fafc;border:1px solid #e2e8f0;border-radius:12px;
      padding:20px;margin-top:24px
    }
    .course-preview h4{margin:0 0 12px;color:#1e293b;font-size:1.1rem}
    .course-preview .preview-item{
      display:flex;justify-content:space-between;align-items:center;
      padding:8px 0;border-bottom:1px solid #e2e8f0
    }
    .course-preview .preview-item:last-child{border-bottom:none}
    .course-preview .label{color:#64748b;font-size:.9rem}
    .course-preview .value{color:#1e293b;font-weight:600}
    footer{
      margin-top:auto;padding:32px 24px;text-align:center;
      color:#64748b;background:#f8fafc;
      border-top:1px solid #e2e8f0
    }
    @media (max-width:768px){
      .nav{padding:14px 16px}
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
    <div class="brand">🛠️ ABC Institute - Admin Dashboard</div>
    <a class="logout" href="<%=request.getContextPath()%>/logout">Logout</a>
  </div>
  <div class="main">
    <div class="container">
      <div class="page-header">
        <h2>📚 Add New Course</h2>
        <p>Create a new course for students to enroll</p>
      </div>
      <div class="form-card">
        <form action="<%=request.getContextPath()%>/adminAction" method="post">
          <input type="hidden" name="action" value="addCourse">
          <div class="form-grid">
            <div class="form-group">
              <label>Course ID</label>
              <input name="course_id" placeholder="e.g. CS101" required>
              <div class="form-hint">Unique identifier for the course</div>
            </div>
            <div class="form-group">
              <label>Course Name</label>
              <input name="course_name" placeholder="e.g. Introduction to Computer Science" required>
              <div class="form-hint">Full descriptive name of the course</div>
            </div>
          </div>
          <div class="form-group">
            <label>Stream/Department</label>
            <input name="stream" placeholder="e.g. Computing, Engineering, Business" required>
            <div class="form-hint">Academic department or field of study</div>
          </div>
          <div class="form-group">
            <label>Course Description</label>
            <textarea name="description" placeholder="Enter a detailed description of the course content, objectives, and requirements..."></textarea>
            <div class="form-hint">Optional: Provide detailed information about the course</div>
          </div>
          
          <div class="course-preview">
            <h4>📋 Course Preview</h4>
            <div class="preview-item">
              <span class="label">Course ID:</span>
              <span class="value" id="preview-id">Not set</span>
            </div>
            <div class="preview-item">
              <span class="label">Course Name:</span>
              <span class="value" id="preview-name">Not set</span>
            </div>
            <div class="preview-item">
              <span class="label">Stream:</span>
              <span class="value" id="preview-stream">Not set</span>
            </div>
          </div>

          <div class="actions">
            <button class="btn btn-success" type="submit">✅ Add Course</button>
            <a class="btn btn-outline" href="admin-dashboard.jsp">← Back to Dashboard</a>
          </div>

          <% if(request.getParameter("msg") != null) { %>
          <div class="success-msg show">✅ Course added successfully!</div>
          <% } %>
        </form>
      </div>
    </div>
  </div>
  <footer>&copy; 2025 ABC Institute. All rights reserved.</footer>

  <script>
    // Real-time preview updates
    const courseIdInput = document.querySelector('input[name="course_id"]');
    const courseNameInput = document.querySelector('input[name="course_name"]');
    const streamInput = document.querySelector('input[name="stream"]');
    
    const previewId = document.getElementById('preview-id');
    const previewName = document.getElementById('preview-name');
    const previewStream = document.getElementById('preview-stream');

    courseIdInput.addEventListener('input', () => {
      previewId.textContent = courseIdInput.value || 'Not set';
    });

    courseNameInput.addEventListener('input', () => {
      previewName.textContent = courseNameInput.value || 'Not set';
    });

    streamInput.addEventListener('input', () => {
      previewStream.textContent = streamInput.value || 'Not set';
    });
  </script>
</body>
</html>