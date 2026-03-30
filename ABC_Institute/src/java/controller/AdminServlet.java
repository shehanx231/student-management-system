package controller;

import util.dbConnect;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/adminAction")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("addCourse".equals(action)) {
                addCourse(req, resp);
            } else if ("changeStudentCourse".equals(action)) {
                changeStudentCourse(req, resp);
            } else if ("removeStudent".equals(action)) {
                removeStudent(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void addCourse(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        String cid = req.getParameter("course_id");
        String cname = req.getParameter("course_name");
        String stream = req.getParameter("stream");
        String desc = req.getParameter("description");

        try (Connection conn = new dbConnect().connect()) {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO course (course_id, course_name, stream, description) VALUES (?,?,?,?)"
            );
            ps.setString(1, cid);
            ps.setString(2, cname);
            ps.setString(3, stream);
            ps.setString(4, desc);
            ps.executeUpdate();
        }
        resp.sendRedirect(req.getContextPath()+"/admin/admin-dashboard.jsp?msg=Course+added");
    }

    private void changeStudentCourse(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        int registrationId = Integer.parseInt(req.getParameter("registration_id"));
        String newCourseId = req.getParameter("new_course_id");

        try (Connection conn = new dbConnect().connect()) {
            PreparedStatement ps = conn.prepareStatement("UPDATE registration SET course_id=? WHERE id=?");
            ps.setString(1, newCourseId);
            ps.setInt(2, registrationId);
            ps.executeUpdate();
        }
        resp.sendRedirect(req.getContextPath()+"/admin/view-students.jsp?msg=Updated");
    }

    private void removeStudent(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        int studentId = Integer.parseInt(req.getParameter("student_id"));
        try (Connection conn = new dbConnect().connect()) {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM student WHERE id=?");
            ps.setInt(1, studentId);
            ps.executeUpdate();
        }
        resp.sendRedirect(req.getContextPath()+"/admin/view-students.jsp?msg=Removed");
    }
}
