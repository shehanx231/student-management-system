package controller;

import util.dbConnect;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/studentAction")
public class StudentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            switch (action) {
                case "updateProfile": updateProfile(req, resp); break;
                case "changePassword": changePassword(req, resp); break;
                case "selectCourse": selectCourse(req, resp); break;
                default: resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void updateProfile(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        int studentId = Integer.parseInt(req.getParameter("student_id"));
        String first = req.getParameter("first_name");
        String last  = req.getParameter("last_name");
        String dob   = req.getParameter("dob");
        String address = req.getParameter("address");
        String phone   = req.getParameter("phone");

        try (Connection conn = new dbConnect().connect()) {
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE student SET first_name=?, last_name=?, dob=?, address=?, phone=? WHERE id=?"
            );
            ps.setString(1, first);
            ps.setString(2, last);
            ps.setDate(3, java.sql.Date.valueOf(dob));
            ps.setString(4, address);
            ps.setString(5, phone);
            ps.setInt(6, studentId);
            ps.executeUpdate();
        }
        resp.sendRedirect(req.getContextPath()+"/student/profile.jsp?msg=Profile+updated");
    }

    private void changePassword(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException, ServletException {
        int studentId = Integer.parseInt(req.getParameter("student_id"));
        String oldP = req.getParameter("old_password");
        String newP = req.getParameter("new_password");

        try (Connection conn = new dbConnect().connect()) {
            PreparedStatement chk = conn.prepareStatement("SELECT password FROM student WHERE id=?");
            chk.setInt(1, studentId);
            ResultSet rs = chk.executeQuery();
            if (rs.next() && rs.getString(1).equals(oldP)) {
                PreparedStatement up = conn.prepareStatement("UPDATE student SET password=? WHERE id=?");
                up.setString(1, newP);
                up.setInt(2, studentId);
                up.executeUpdate();
                resp.sendRedirect(req.getContextPath()+"/student/change-password.jsp?msg=Password+changed");
                return;
            }
        }
        req.setAttribute("error","Old password is incorrect");
        req.getRequestDispatcher("/student/change-password.jsp").forward(req, resp);
    }

    private void selectCourse(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        int studentId = Integer.parseInt(req.getParameter("student_id"));
        String batchNo = req.getParameter("batch_no");
        String email   = req.getParameter("email");
        String stream  = req.getParameter("stream");
        String courseId= req.getParameter("course_id");

        try (Connection conn = new dbConnect().connect()) {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO registration (student_id, batch_no, email, stream, course_id) VALUES (?,?,?,?,?)"
            );
            ps.setInt(1, studentId);
            ps.setString(2, batchNo);
            ps.setString(3, email);
            ps.setString(4, stream);
            ps.setString(5, courseId);
            ps.executeUpdate();
        }

        resp.sendRedirect(req.getContextPath()+"/student/registration-success.jsp?courseId="+courseId);
    }
}
