package model;

public class User {
    private int userId;
    private String username;
    private String firstName;
    private String lastName;
    private String password;
    private String email;
    private String role;
    private String contactNumber;
    private Address address;
    private double totalAmountSpent;

    public User() {
        // Default constructor
    }

    // Constructor with all attributes
    public User(int userId, String username, String firstName, String lastName, String password, String email,
                String role, String contactNumber, Address address) {
        this.userId = userId;
        this.username = username;
        this.firstName = firstName;
        this.lastName = lastName;
        this.password = password;
        this.email = email;
        this.role = role;
        this.contactNumber = contactNumber;
        this.address = address;
    }
    
    public User(int userId, String username, double totalAmountSpent) {
    	this.userId = userId;
        this.username = username;
        this.totalAmountSpent = totalAmountSpent;
    }
    

    public User(int userId, String username, String firstName, String lastName, String email,String role, String contactNumber, 
    		Address address) {
    this.userId = userId;
    this.username = username;
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.role = role;
    this.contactNumber = contactNumber;
    this.address = address;
}

    public User(String firstName, String lastName) {
    	this.firstName = firstName;
    	this.lastName = lastName;
    }


    // Getters and setters for the attributes

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }
    
    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

	public double getTotalAmountSpent() {
		return totalAmountSpent;
	}

	public void setTotalAmountSpent(double totalAmountSpent) {
		this.totalAmountSpent = totalAmountSpent;
	}

   
}
