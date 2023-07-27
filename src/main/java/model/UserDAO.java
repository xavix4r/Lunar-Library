package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
	
	
	
	


}
