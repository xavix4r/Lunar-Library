
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class UserDAO {
	
	public int getUserIDByUsername(String username) throws SQLException{
	    int userId = -1; // Default value to indicate user not found

	    try {
	        // Establish a database connection
	        Connection conn = DBConnection.getConnection();

	        String sql = "SELECT user_id FROM users WHERE username = ?";
	        PreparedStatement pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, username);

	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            // If the result set has a row, retrieve the user_id from the result set
	            userId = rs.getInt("user_id");
	        }

	        // Close the result set, statement, and connection
	        rs.close();
	        pstmt.close();
	        conn.close();
	    } catch (SQLException e) {
	        // Handle the exceptions
	        e.printStackTrace();
	        throw e;
	    }

	    return userId;
	}
	
	public User getFirstAndLastNameById(int userid) throws SQLException, ClassNotFoundException{
		User user = null;
	 
	    try {
	        // Establish a database connection
	        Connection conn = DBConnection.getConnection();

	        String sql = "SELECT fname, lname FROM users WHERE user_id = ?";
	        PreparedStatement pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, userid);

	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	           user = new User();
	          user.setFirstName(rs.getString("fname"));
	           user.setLastName(rs.getString("lname"));
	        }

	        rs.close();
	        pstmt.close();
	        conn.close();
	    } catch (SQLException e) {
	      
	        e.printStackTrace();
	        throw e;
	    }

	    return user;
	}
	
	
	public User getUserById(int userId) throws SQLException {
        User user = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT u.user_id, u.username, u.fname, u.lname, u.email, u.role, c.contactNo, a.address_line1, a.address_line2, a.postal " +
                    "FROM users u " +
                    "LEFT JOIN users_contact c ON u.user_id = c.user_id " +
                    "LEFT JOIN users_address a ON u.user_id = a.user_id " +
                    "WHERE u.user_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String username = rs.getString("username");
                String firstName = rs.getString("fname");
                String lastName = rs.getString("lname");
                String email = rs.getString("email");
                String role = rs.getString("role");
                String contactNumber = rs.getString("contactNo");
                String addressLine1 = rs.getString("address_line1");
                String addressLine2 = rs.getString("address_line2");
                int postal = rs.getInt("postal");

                Address address = new Address(userId, addressLine1, addressLine2, postal);

                user = new User(userId, username, firstName, lastName, null, email, role, contactNumber, address);
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return user;
    }
	
	// Method to update user details in the database
	public void updateUser(User user) throws SQLException {
	    try {
	        Connection conn = DBConnection.getConnection();
	        String sql = "UPDATE users u " +
	                     "LEFT JOIN users_address a ON u.user_id = a.user_id " +
	                     "LEFT JOIN users_contact c ON u.user_id = c.user_id " +
	                     "SET u.fname = ?, u.lname = ?, u.email = ?, " +
	                     "c.contactNo = ?, a.address_line1 = ?, a.address_line2 = ?, a.postal = ? " +
	                     "WHERE u.user_id = ?";
	        PreparedStatement pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, user.getFirstName());
	        pstmt.setString(2, user.getLastName());
	        pstmt.setString(3, user.getEmail());
	        pstmt.setString(4, user.getContactNumber());
	        pstmt.setString(5, user.getAddress().getAddressLine1());
	        pstmt.setString(6, user.getAddress().getAddressLine2());
	        pstmt.setInt(7, user.getAddress().getPostal());
	        pstmt.setInt(8, user.getUserId());

	        pstmt.executeUpdate();
	        pstmt.close();
	        conn.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw e;
	    }
	}


    // Method to delete a user from the database
	public void deleteUserAndRelatedData(int userId) throws SQLException {
        try {
            Connection conn = DBConnection.getConnection();

            // Delete from users_address table
            String deleteAddressSQL = "DELETE FROM users_address WHERE user_id = ?";
            PreparedStatement deleteAddressStmt = conn.prepareStatement(deleteAddressSQL);
            deleteAddressStmt.setInt(1, userId);
            deleteAddressStmt.executeUpdate();

            // Delete from users_contact table
            String deleteContactSQL = "DELETE FROM users_contact WHERE user_id = ?";
            PreparedStatement deleteContactStmt = conn.prepareStatement(deleteContactSQL);
            deleteContactStmt.setInt(1, userId);
            deleteContactStmt.executeUpdate();

            // Delete from users table
            String deleteUserSQL = "DELETE FROM users WHERE user_id = ?";
            PreparedStatement deleteUserStmt = conn.prepareStatement(deleteUserSQL);
            deleteUserStmt.setInt(1, userId);
            deleteUserStmt.executeUpdate();

            // Close the statements and connection
            deleteAddressStmt.close();
            deleteContactStmt.close();
            deleteUserStmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public void updateContactNumber(int userId, String contactNumber) throws SQLException {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO users_contact (user_id, contactNo) VALUES (?, ?) " +
                         "ON DUPLICATE KEY UPDATE contactNo = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setString(2, contactNumber);
            pstmt.setString(3, contactNumber);

            pstmt.executeUpdate();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public void updateAddress(int userId, Address address) throws SQLException {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO users_address (user_id, address_line1, address_line2, postal) " +
                         "VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE " +
                         "address_line1 = VALUES(address_line1), " +
                         "address_line2 = VALUES(address_line2), " +
                         "postal = VALUES(postal)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setString(2, address.getAddressLine1());
            pstmt.setString(3, address.getAddressLine2());
            pstmt.setInt(4, address.getPostal());

            int rowsAffected = pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            if (rowsAffected == 0) {
                System.out.println("No rows affected. Check if the user_id already exists in the users_address table.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public Address getAddressByUserId(int userId) throws SQLException {
        Address address = null;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT address_line1, address_line2, postal FROM users_address WHERE user_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String addressLine1 = rs.getString("address_line1");
                String addressLine2 = rs.getString("address_line2");
                int postal = rs.getInt("postal");

                address = new Address(userId, addressLine1, addressLine2, postal);
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return address;
    }
    
    public List<User> getAllUsers(String orderBy) throws SQLException {
        List<User> users = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT u.user_id, u.username, u.fname, u.lname, u.email, u.role, c.contactNo, a.address_line1, a.address_line2, a.postal "
                    + "FROM users u "
                    + "LEFT JOIN users_contact c ON u.user_id = c.user_id "
                    + "LEFT JOIN users_address a ON u.user_id = a.user_id ";

            // Check the sorting order and modify the SQL query accordingly
            if ("usernameAsc".equals(orderBy)) {
                sql += "ORDER BY u.username ASC";
            } else if ("usernameDesc".equals(orderBy)) {
                sql += "ORDER BY u.username DESC";
            } else if ("postalAsc".equals(orderBy)) {
                sql += "ORDER BY a.postal ASC";
            } else if ("postalDesc".equals(orderBy)) {
                sql += "ORDER BY a.postal DESC";
            } else if ("addressAsc".equals(orderBy)) {
                sql += "ORDER BY a.address_line1 ASC";
            } else if ("addressDesc".equals(orderBy)) {
                sql += "ORDER BY a.address_line1 DESC";
            } else {
                // Default sorting by user ID
                sql += "ORDER BY u.user_id ASC";
            }

            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                int userId = rs.getInt("user_id");
                String username = rs.getString("username");
                String firstName = rs.getString("fname");
                String lastName = rs.getString("lname");
                String email = rs.getString("email");
                String role = rs.getString("role");
                String contactNumber = rs.getString("contactNo");
                String addressLine1 = rs.getString("address_line1");
                String addressLine2 = rs.getString("address_line2");
                int postal = rs.getInt("postal");

                Address address = new Address(userId, addressLine1, addressLine2, postal);

                User user = new User(userId, username, firstName, lastName, null, email, role, contactNumber, address);
                users.add(user);
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }

        return users;
    }


    
    
    
}