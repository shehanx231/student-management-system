package controller;

import util.dbConnect;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class StudentActionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("selectCourse".equals(action)) {
            int studentId = Integer.parseInt(request.getParameter("student_id"));
            String courseId = request.getParameter("course_id");
            String courseName = request.getParameter("course_name");
            String stream = request.getParameter("stream");
            String batchNo = request.getParameter("batch_no");

            try (Connection conn = new dbConnect().connect()) {
                // Insert into registration including stream
                PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO registration(student_id, course_id, stream, batch_no, created_at) VALUES(?,?,?,?,NOW())");
                ps.setInt(1, studentId);
                ps.setString(2, courseId);
                ps.setString(3, stream);
                ps.setString(4, batchNo);
                ps.executeUpdate();
                ps.close();

                request.setAttribute("courseId", courseId);
                request.setAttribute("courseName", courseName);
                RequestDispatcher rd = request.getRequestDispatcher("/student/registration-success.jsp");
                rd.forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("msg", "Registration failed: " + e.getMessage());
                RequestDispatcher rd = request.getRequestDispatcher("/student/select-course.jsp");
                rd.forward(request, response);
            }
        }
    }
}
