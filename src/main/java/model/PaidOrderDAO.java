package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;


public class PaidOrderDAO {
	
	public ArrayList<PaidOrder> getAllPaidOrders(int userid) throws SQLException, ClassNotFoundException {
	    ArrayList<PaidOrder> paidOrders = new ArrayList<>();
	    
	    // Establish a database connection
	    Connection conn = DBConnection.getConnection();
	    
	    // Prepare the SQL statement
	    String sql = "SELECT * FROM orders WHERE user_id = ?";
	    PreparedStatement pstmt = conn.prepareStatement(sql);
	    pstmt.setInt(1, userid);
	    
	    // Execute the query and obtain the result set
	    ResultSet rs = pstmt.executeQuery();
	    
	    // Process the result set
	    while (rs.next()) {
	        // Retrieve the data from each row
	        int userId = rs.getInt("user_id");
	        int orderId = rs.getInt("order_id");
	        double total = rs.getDouble("total_price");
	        Date orderDate = rs.getTimestamp("order_date");
	        
	        // Create a PaidOrder object and add it to the list
	        PaidOrder paidOrder = new PaidOrder(userId, orderId, total, orderDate);
	        paidOrders.add(paidOrder);
	    }
	    
	    // Close the result set, statement, and connection
	    rs.close();
	    pstmt.close();
	    conn.close();
	    
	    // Return the list of paid orders
	    return paidOrders;
	}

	public ArrayList<Integer> getAllOrderIdsByUserid (int userid) throws SQLException, ClassNotFoundException{
		
		 ArrayList<Integer> allOrderIds = new ArrayList<>();
		    
		    // Establish a database connection
		    Connection conn = DBConnection.getConnection();
		    
		    String sql = "SELECT order_id FROM orders WHERE user_id = ?";
		    PreparedStatement pstmt = conn.prepareStatement(sql);
		    pstmt.setInt(1, userid);
		    
		    ResultSet rs = pstmt.executeQuery();
		    
		    while (rs.next()) {
		        // Retrieve the data from each row
		        int orderid = rs.getInt("order_id");
		        
		        
		       
		       
		        allOrderIds.add(orderid);
		    }
		    
		    // Close the result set, statement, and connection
		    rs.close();
		    pstmt.close();
		    conn.close();
		    
		    // Return the list of paid orders
		    return allOrderIds;
		
	}
	
	public ArrayList<User> getCustomerValueRanking () throws SQLException, ClassNotFoundException{
		
		 ArrayList<User> allUsers = new ArrayList<>();
		    
		    // Establish a database connection
		    Connection conn = DBConnection.getConnection();
		    
		    String sql = "SELECT orders.user_id, users.username ,SUM(orders.total_price) as grandTotal FROM orders, users WHERE orders.user_id = users.user_id GROUP BY user_id ORDER BY grandTotal DESC;";
		    PreparedStatement pstmt = conn.prepareStatement(sql);
		    ResultSet rs = pstmt.executeQuery();
		    
		    while (rs.next()) {
		        // Retrieve the data from each row
		        int userid = rs.getInt("user_id");
		        String username = rs.getString("username");
		        double grandtotal = rs.getDouble("grandTotal");
		        
		        User user = new User(userid, username, grandtotal);
		       
		        
		       
		        allUsers.add(user);
		    }
		    
		    // Close the result set, statement, and connection
		    rs.close();
		    pstmt.close();
		    conn.close();
		    
		    // Return the list of paid orders
		    return allUsers;
		
	}
	
	
	
	
	
	

}
