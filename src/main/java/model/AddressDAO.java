package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import model.DBConnection;

public class AddressDAO {
	
	public int insertAddress(int userid, String address_line1, String address_line2, int postal) throws SQLException, ClassNotFoundException {
		Connection conn = null;
		
		int nrow =  0;
		
		try {
			conn = DBConnection.getConnection();
			String sqlStr = "INSERT INTO users_address VALUES (?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setInt(1, userid);
			pstmt.setString(2, address_line1);
			pstmt.setString(3, address_line2);
			pstmt.setInt(4, postal);
			nrow = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return nrow;
	}
	
	public int updateAddress(int userid, String address_line1, String address_line2, int postal) throws SQLException, ClassNotFoundException {
	    Connection conn = null;
	    int nrow = 0;
	    
	    try {
	        conn = DBConnection.getConnection();
	        String sqlStr = "UPDATE users_address SET address_line1 = ?, address_line2 = ?, postal = ? WHERE user_id = ?";
	        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	        pstmt.setString(1, address_line1);
	        pstmt.setString(2, address_line2);
	        pstmt.setInt(3, postal);
	        pstmt.setInt(4, userid);
	        
	        nrow = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        if (conn != null) {
	            conn.close();
	        }
	    }
	    
	    return nrow;
	}


}
