package model;

public class Student {
    private int id;
    private int indexNo;
    private String firstName;
    private String lastName;
    private String dob;       // keep as String for simple JSP binding
    private String address;
    private String phone;
    private String email;
    private String password;

    public Student() {}

    public Student(int id, int indexNo, String firstName, String lastName, String dob,
                   String address, String phone, String email, String password) {
        this.id = id;
        this.indexNo = indexNo;
        this.firstName = firstName;
        this.lastName = lastName;
        this.dob = dob;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.password = password;
    }
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getIndexNo() { return indexNo; }
    public void setIndexNo(int indexNo) { this.indexNo = indexNo; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public String getDob() { return dob; }
    public void setDob(String dob) { this.dob = dob; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
