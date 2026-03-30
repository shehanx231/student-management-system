package model;

public class Registration {
    private int id;
    private int studentId;
    private String batchNo;
    private String email;
    private String stream;
    private String courseId;

    public Registration() {}

    public Registration(int id, int studentId, String batchNo, String email, String stream, String courseId) {
        this.id = id;
        this.studentId = studentId;
        this.batchNo = batchNo;
        this.email = email;
        this.stream = stream;
        this.courseId = courseId;
    }
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    public String getBatchNo() { return batchNo; }
    public void setBatchNo(String batchNo) { this.batchNo = batchNo; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getStream() { return stream; }
    public void setStream(String stream) { this.stream = stream; }
    public String getCourseId() { return courseId; }
    public void setCourseId(String courseId) { this.courseId = courseId; }
}
