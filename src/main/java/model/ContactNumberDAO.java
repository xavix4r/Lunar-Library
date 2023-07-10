package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ContactNumberDAO {
	public int insertContactNumber(int userid, String contactNo) throws SQLException, ClassNotFoundException {
		Connection conn = null;
		
		int nrow =  0;
		
		try {
			conn = DBConnection.getConnection();
			String sqlStr = "INSERT INTO users_contact VALUES (?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setInt(1, userid);
			pstmt.setString(2, contactNo);
			
			nrow = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return nrow;
	}
}
