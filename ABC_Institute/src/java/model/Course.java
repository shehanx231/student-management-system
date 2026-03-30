package model;

public class Course {
    private int id;
    private String courseId;
    private String courseName;
    private String stream;
    private String description;

    public Course() {}

    public Course(int id, String courseId, String courseName, String stream, String description) {
        this.id = id;
        this.courseId = courseId;
        this.courseName = courseName;
        this.stream = stream;
        this.description = description;
    }
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getCourseId() { return courseId; }
    public void setCourseId(String courseId) { this.courseId = courseId; }
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    public String getStream() { return stream; }
    public void setStream(String stream) { this.stream = stream; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
