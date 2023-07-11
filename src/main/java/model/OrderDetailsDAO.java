package model;

import java.sql.*;
import java.util.ArrayList;

public class OrderDetailsDAO {

	public int insertOrder(int userid, double totalPrice) throws SQLException, ClassNotFoundException {
	    Connection conn = null;
	    int orderId = 0;

	    try {
	        conn = DBConnection.getConnection();
	        String sqlStr = "INSERT INTO orders (user_id, order_date, total_price) VALUES (?, CURRENT_TIMESTAMP, ?)";
	        PreparedStatement pstmt = conn.prepareStatement(sqlStr, Statement.RETURN_GENERATED_KEYS);
	        pstmt.setInt(1, userid);
	        pstmt.setDouble(2, totalPrice);

	        int numRowsAffected = pstmt.executeUpdate();

	        if (numRowsAffected > 0) {
	            ResultSet generatedKeys = pstmt.getGeneratedKeys();
	            if (generatedKeys.next()) {
	                orderId = generatedKeys.getInt(1);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        if (conn != null) {
	            conn.close();
	        }
	    }

	    return orderId;
	}

	
	public int insertOrderItems(int orderId, ArrayList<OrderDetails> allOrderDetails) throws SQLException, ClassNotFoundException {
	    Connection conn = null;
	    int numRowsAffected = 0;

	    try {
	        conn = DBConnection.getConnection();
	        String sqlStr = "INSERT INTO order_items (order_id, book_id, quantityOrdered) VALUES (?, ?, ?)";
	        PreparedStatement pstmt = conn.prepareStatement(sqlStr);

	        for (OrderDetails orderDetails : allOrderDetails) {
	            pstmt.setInt(1, orderId);
	            pstmt.setInt(2, orderDetails.getbookId());
	            pstmt.setInt(3, orderDetails.getQuantityInt());

	            numRowsAffected += pstmt.executeUpdate();
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        if (conn != null) {
	            conn.close();
	        }
	    }

	    return numRowsAffected;
	}
	
	public int insertOrderAddress(int orderId, String address1, String address2, int postal) throws SQLException, ClassNotFoundException {
	    Connection conn = null;
	    int numRowsAffected = 0;

	    try {
	        conn = DBConnection.getConnection();
	        String sqlStr = "INSERT INTO order_address (order_id, address_line1, address_line2, postal) VALUES (?, ?, ?, ?)";
	        PreparedStatement pstmt = conn.prepareStatement(sqlStr);

	       
	            pstmt.setInt(1, orderId);
	            pstmt.setString(2, address1);
	            pstmt.setString(3, address2);
	            pstmt.setInt(4, postal);

	            numRowsAffected = pstmt.executeUpdate();
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        if (conn != null) {
	            conn.close();
	        }
	    }

	    return numRowsAffected;
	}

	
	
}
