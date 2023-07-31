package model;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List; 

public class CustomerInquiryDAO {
	public void saveCustomerInquiry(CustomerInquiry inquiry) throws SQLException {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO customer_inquiries (user_id, inquiry_type, inquiry_text, require_response, email) "
                    + "VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, inquiry.getUserId());
            pstmt.setString(2, inquiry.getInquiryType());
            pstmt.setString(3, inquiry.getInquiryText());
            pstmt.setBoolean(4, inquiry.isRequireResponse());
            pstmt.setString(5, inquiry.getEmail());

            pstmt.executeUpdate();

            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
	
	public boolean deleteCustomerInquiry(int inquiryId) throws SQLException {
	    try {
	        Connection conn = DBConnection.getConnection();
	        String sql = "DELETE FROM customer_inquiries WHERE id = ?";
	        PreparedStatement pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, inquiryId);
	        int rowsDeleted = pstmt.executeUpdate();
	        pstmt.close();
	        conn.close();

	        return rowsDeleted > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw e;
	    }
	}

	public List<CustomerInquiry> getAllInquiries() throws SQLException {
	    List<CustomerInquiry> inquiries = new ArrayList<>();
	    try {
	        Connection conn = DBConnection.getConnection();
	        String sql = "SELECT * FROM customer_inquiries";
	        Statement stmt = conn.createStatement();
	        ResultSet rs = stmt.executeQuery(sql);

	        while (rs.next()) {
	            int inquiryId = rs.getInt("id"); // Use the correct column name 'id'
	            int userId = rs.getInt("user_id");
	            String inquiryType = rs.getString("inquiry_type");
	            String inquiryText = rs.getString("inquiry_text");
	            boolean requireResponse = rs.getBoolean("require_response");
	            String email = rs.getString("email");

	            CustomerInquiry inquiry = new CustomerInquiry(inquiryId, userId, inquiryType, inquiryText, requireResponse, email);
	            inquiries.add(inquiry);
	        }

	        rs.close();
	        stmt.close();
	        conn.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw e;
	    }

	    return inquiries;
	}

}
