package org.apache.jsp.auth;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class signup_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("  <meta charset=\"UTF-8\">\n");
      out.write("  <title>Sign Up - ABC Institute</title>\n");
      out.write("  <link href=\"https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap\" rel=\"stylesheet\">\n");
      out.write("  <style>\n");
      out.write("    *{box-sizing:border-box;font-family:Poppins,system-ui,Arial}\n");
      out.write("    body{\n");
      out.write("      min-height:100vh;margin:0;display:grid;place-items:center;\n");
      out.write("      background:url('https://images.unsplash.com/photo-1529666412384-0a7b1a3b4a3b?q=80&w=1600&auto=format&fit=crop') center/cover no-repeat fixed;\n");
      out.write("    }\n");
      out.write("    .overlay{position:fixed;inset:0;background:rgba(0,0,0,.45)}\n");
      out.write("    .card{position:relative;z-index:1;width:min(780px,94vw);background:#fff;border-radius:14px;padding:24px 26px;box-shadow:0 20px 60px rgba(0,0,0,.25)}\n");
      out.write("    h2{margin:0 0 10px;color:#0b3b6f}\n");
      out.write("    .grid{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:14px}\n");
      out.write("    .grid .full{grid-column:1 / -1}\n");
      out.write("    label{display:block;font-weight:600;margin:8px 0 6px}\n");
      out.write("    input,textarea{width:100%;padding:12px 14px;border:1px solid #cbd5e1;border-radius:10px}\n");
      out.write("    textarea{min-height:74px;resize:vertical}\n");
      out.write("    .agree{display:flex;gap:10px;align-items:center;margin-top:4px}\n");
      out.write("    .btn{margin-top:10px;width:100%;padding:12px 14px;background:#10b981;color:#fff;border:0;border-radius:10px;font-weight:700;cursor:pointer}\n");
      out.write("    .btn:hover{filter:brightness(.95)}\n");
      out.write("  </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("<div class=\"overlay\"></div>\n");
      out.write("<div class=\"card\">\n");
      out.write("  <h2>Create your account</h2>\n");
      out.write("  <form action=\"");
      out.print(request.getContextPath());
      out.write("/auth\" method=\"post\">\n");
      out.write("    <input type=\"hidden\" name=\"action\" value=\"signup\">\n");
      out.write("    <div class=\"grid\">\n");
      out.write("      <div>\n");
      out.write("        <label>First Name</label>\n");
      out.write("        <input type=\"text\" name=\"first_name\" required>\n");
      out.write("      </div>\n");
      out.write("      <div>\n");
      out.write("        <label>Last Name</label>\n");
      out.write("        <input type=\"text\" name=\"last_name\" required>\n");
      out.write("      </div>\n");
      out.write("      <div>\n");
      out.write("        <label>Date of Birth</label>\n");
      out.write("        <input type=\"date\" name=\"dob\" required>\n");
      out.write("      </div>\n");
      out.write("      <div>\n");
      out.write("        <label>Phone</label>\n");
      out.write("        <input type=\"text\" name=\"phone\" required>\n");
      out.write("      </div>\n");
      out.write("      <div class=\"full\">\n");
      out.write("        <label>Address</label>\n");
      out.write("        <textarea name=\"address\" required></textarea>\n");
      out.write("      </div>\n");
      out.write("      <div>\n");
      out.write("        <label>Email</label>\n");
      out.write("        <input type=\"email\" name=\"email\" required>\n");
      out.write("      </div>\n");
      out.write("      <div>\n");
      out.write("        <label>Password</label>\n");
      out.write("        <input type=\"password\" name=\"password\" required>\n");
      out.write("      </div>\n");
      out.write("      <div class=\"full agree\">\n");
      out.write("        <input type=\"checkbox\" required>\n");
      out.write("        <span>I agree to the Terms & Conditions</span>\n");
      out.write("      </div>\n");
      out.write("    </div>\n");
      out.write("    <button class=\"btn\" type=\"submit\">Sign Up</button>\n");
      out.write("  </form>\n");
      out.write("</div>\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
