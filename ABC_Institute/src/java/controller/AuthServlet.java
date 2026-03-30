package controller;

import util.dbConnect;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {

    private int getNextIndexNo(Connection conn) throws SQLException {
        int start = 30500;
        try (PreparedStatement ps = conn.prepareStatement("SELECT MAX(index_no) FROM student");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                int max = rs.getInt(1);
                if (rs.wasNull()) return start;
                return max + 1;
            }
        }
        return start;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("signup".equals(action)) {
            signup(req, resp);
        } else if ("login".equals(action)) {
            login(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void signup(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String first = req.getParameter("first_name");
        String last  = req.getParameter("last_name");
        String dob   = req.getParameter("dob");
        String address = req.getParameter("address");
        String phone   = req.getParameter("phone");
        String email   = req.getParameter("email");
        String pass    = req.getParameter("password");

        try (Connection conn = new dbConnect().connect()) {
            if (conn == null) throw new SQLException("Database connection failed");

            int nextIndex = getNextIndexNo(conn);
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO student (index_no, first_name, last_name, dob, address, phone, email, password) " +
                "VALUES (?,?,?,?,?,?,?,?)"
            );
            ps.setInt(1, nextIndex);
            ps.setString(2, first);
            ps.setString(3, last);
            ps.setDate(4, java.sql.Date.valueOf(dob));
            ps.setString(5, address);
            ps.setString(6, phone);
            ps.setString(7, email);
            ps.setString(8, pass);
            ps.executeUpdate();

            HttpSession s = req.getSession(true);
            s.setAttribute("studentName", first);
            s.setAttribute("studentIndex", nextIndex);

            resp.sendRedirect(req.getContextPath() + "/student/dashboard.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Signup failed: " + e.getMessage());
            req.getRequestDispatcher("/auth/signup.jsp").forward(req, resp);
        }
    }

    private void login(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String email = req.getParameter("email");
        String pass  = req.getParameter("password");

        try (Connection conn = new dbConnect().connect()) {
            if (conn == null) throw new SQLException("Database connection failed");

            // Admin login
            try (PreparedStatement pa = conn.prepareStatement("SELECT id FROM admin_user WHERE email=? AND password=?")) {
                pa.setString(1, email);
                pa.setString(2, pass);
                try (ResultSet ra = pa.executeQuery()) {
                    if (ra.next()) {
                        HttpSession s = req.getSession(true);
                        s.setAttribute("admin", true);
                        s.setAttribute("adminEmail", email);
                        resp.sendRedirect(req.getContextPath() + "/admin/admin-dashboard.jsp");
                        return;
                    }
                }
            }

            // Student login
            PreparedStatement ps = conn.prepareStatement("SELECT id, first_name, index_no FROM student WHERE email=? AND password=?");
            ps.setString(1, email);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                HttpSession s = req.getSession(true);
                s.setAttribute("studentId", rs.getInt("id"));
                s.setAttribute("studentName", rs.getString("first_name"));
                s.setAttribute("studentIndex", rs.getInt("index_no"));
                resp.sendRedirect(req.getContextPath() + "/student/dashboard.jsp");
            } else {
                req.setAttribute("error", "Invalid email or password");
                req.getRequestDispatcher("/auth/login.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
