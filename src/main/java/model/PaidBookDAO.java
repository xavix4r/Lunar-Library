package model;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;

public class PaidBookDAO {
	
	public ArrayList<Integer> getAllPaidBookIds (int orderid) throws SQLException, ClassNotFoundException{
		
		 ArrayList<Integer> paidBookIds = new ArrayList<>();
		    
		    // Establish a database connection
		    Connection conn = DBConnection.getConnection();
		    
		    String sql = "SELECT book_id FROM order_items WHERE order_id = ?";
		    PreparedStatement pstmt = conn.prepareStatement(sql);
		    pstmt.setInt(1, orderid);
		    
		    ResultSet rs = pstmt.executeQuery();
		    
		    while (rs.next()) {
		        // Retrieve the data from each row
		        int bookid = rs.getInt("book_id");
		        
		        
		        // Create a PaidOrder object and add it to the list
		       
		        paidBookIds.add(bookid);
		    }
		    
		    // Close the result set, statement, and connection
		    rs.close();
		    pstmt.close();
		    conn.close();
		    
		    // Return the list of paid orders
		    return paidBookIds;
		
	}
	
	public ArrayList<PaidBook> getAllPaidBookDetails (ArrayList<Integer> paidbookids ,int orderid) throws SQLException, ClassNotFoundException{
		
		 ArrayList<PaidBook> paidBookDetails = new ArrayList<>();
		    
		    // Establish a database connection
		    Connection conn = DBConnection.getConnection();
		    
		    String sql = "SELECT books.*, order_items.quantityOrdered FROM books JOIN order_items ON books.book_id = order_items.book_id WHERE order_items.book_id = ? AND order_items.order_id = ?";
		    PreparedStatement pstmt = conn.prepareStatement(sql);
		    
		    for (int bookId : paidbookids) {
		        pstmt.setInt(1, bookId);
		        pstmt.setInt(2, orderid);
		        
		        ResultSet rs = pstmt.executeQuery();
		        
		        if (rs.next()) {
		            
		        	String title = rs.getString("title");
		        	String author = rs.getString("author");
		        	Double price = rs.getDouble("price");
		        	int quantity = rs.getInt("quantity");
		        	String publisher = rs.getString("publisher");
		        	Date publication_date = rs.getDate("publication_date");
		        	String isbn = rs.getString("isbn");
		        	String genre = rs.getString("genre");
		        	Double rating = rs.getDouble("rating");
		        	String description = rs.getString("description");
		        	String imgurl = rs.getString("image_url");
		        	int quantityOrdered = rs.getInt("quantityOrdered");
		            
		            // Create a PaidBook object
		            PaidBook paidBook = new PaidBook(bookId, title, author, price, quantity, publisher, publication_date, isbn, genre, rating, description, imgurl, orderid , quantityOrdered);
		            
		            // Add the PaidBook object to the list
		            paidBookDetails.add(paidBook);
		        }
		        
		        rs.close();
		    }
		    pstmt.close();
		    conn.close();
		    
		    // Return the list of paid orders
		    return paidBookDetails;
		
	}
	
	public ArrayList<Integer> getAllBookIdsByDate (String startDate, String endDate) throws SQLException, ClassNotFoundException{
		
		 ArrayList<Integer> paidBookIds = new ArrayList<>();
		    
		    // Establish a database connection
		    Connection conn = DBConnection.getConnection();
		    
		    String sql = "SELECT DISTINCT book_id FROM orders, order_items WHERE orders.order_date BETWEEN ? AND ? AND orders.order_id = order_items.order_id";
		    PreparedStatement pstmt = conn.prepareStatement(sql);
		    pstmt.setString(1, startDate + " 00:00:00"); 
		    pstmt.setString(2, endDate + " 23:59:59");
		    
		    ResultSet rs = pstmt.executeQuery();
		    
		    while (rs.next()) {
		        // Retrieve the data from each row
		        int bookid = rs.getInt("book_id");
		        
		        
		        // Create a PaidOrder object and add it to the list
		       
		        paidBookIds.add(bookid);
		    }
		    
		    // Close the result set, statement, and connection
		    rs.close();
		    pstmt.close();
		    conn.close();
		    
		    // Return the list of paid orders
		    return paidBookIds;
		
	}
	
	public ArrayList<Integer> getAllBookIdsByOrderId (ArrayList<Integer> orderIds) throws SQLException, ClassNotFoundException{
		
		String placeholders = String.join(",", Collections.nCopies(orderIds.size(), "?"));

		
		 ArrayList<Integer> paidBookIds = new ArrayList<>();
		    
		    // Establish a database connection
		    Connection conn = DBConnection.getConnection();
		    
		    String sql = "SELECT DISTINCT book_id FROM order_items WHERE order_id IN (" + placeholders + ")";
		    PreparedStatement pstmt = conn.prepareStatement(sql);
		   
		    for (int i = 0; i < orderIds.size(); i++) {
		        pstmt.setInt(i + 1, orderIds.get(i));
		    }
		    
		    ResultSet rs = pstmt.executeQuery();
		    
		    while (rs.next()) {
		        // Retrieve the data from each row
		        int bookid = rs.getInt("book_id");
		        
		        
		        // Create a PaidOrder object and add it to the list
		       
		        paidBookIds.add(bookid);
		    }
		    
		    // Close the result set, statement, and connection
		    rs.close();
		    pstmt.close();
		    conn.close();
		    
		    // Return the list of paid orders
		    return paidBookIds;
		
	}
	
public ArrayList<Integer> getAmountOrderedForCustomer (ArrayList<Integer> orderIds) throws SQLException, ClassNotFoundException{
		
		String placeholders = String.join(",", Collections.nCopies(orderIds.size(), "?"));

		
		 ArrayList<Integer> totalOrdered = new ArrayList<>();
		    
		    // Establish a database connection
		    Connection conn = DBConnection.getConnection();
		    
		    String sql = "SELECT SUM(quantityOrdered) AS totalOrdered FROM order_items WHERE order_id IN (" + placeholders + ") GROUP BY book_id";
		    PreparedStatement pstmt = conn.prepareStatement(sql);
		   
		    for (int i = 0; i < orderIds.size(); i++) {
		        pstmt.setInt(i + 1, orderIds.get(i));
		    }
		    
		    ResultSet rs = pstmt.executeQuery();
		    
		    while (rs.next()) {
		        // Retrieve the data from each row
		        int bookid = rs.getInt("totalOrdered");
		        
		        
		       
		       
		        totalOrdered.add(bookid);
		    }
		    
		    // Close the result set, statement, and connection
		    rs.close();
		    pstmt.close();
		    conn.close();
		    
		   
		    return totalOrdered;
		
	}
	
	public ArrayList<Integer> getAmountOrderedForPaidBooks(ArrayList<Integer> bookids) throws SQLException, ClassNotFoundException {
	    ArrayList<Integer> amountOrderedEachBook = new ArrayList<>();
	    
	    // Establish a database connection
	    Connection conn = DBConnection.getConnection();
	    
	    String sql = "SELECT SUM(quantityOrdered) as totalOrdered FROM order_items WHERE book_id = ?";
	    PreparedStatement pstmt = conn.prepareStatement(sql);

	    for (Integer bookid : bookids) {
	        pstmt.setInt(1, bookid); // Set the book ID parameter for the query

	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            // Retrieve the total amount ordered for the current book ID
	            int totalOrdered = rs.getInt("totalOrdered");
	            amountOrderedEachBook.add(totalOrdered);
	        } 

	        rs.close();
	    }

	    // Close the statement and connection
	    pstmt.close();
	    conn.close();

	    // Return the list of total ordered quantity for each book
	    return amountOrderedEachBook;
	}
	
	public ArrayList<String> getBookTitlesByBookIds(ArrayList<Integer> bookIds) throws SQLException, ClassNotFoundException {
	    ArrayList<String> bookTitles = new ArrayList<>();
	    
	    // Establish a database connection
	    Connection conn = DBConnection.getConnection();
	    
	    String sql = "SELECT title FROM books WHERE book_id = ?";
	    PreparedStatement pstmt = conn.prepareStatement(sql);

	    for (Integer bookId : bookIds) {
	        pstmt.setInt(1, bookId); // Set the book ID parameter for the query

	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            // Retrieve the title for the current book ID
	            String title = rs.getString("title");
	            bookTitles.add(title);
	        } 

	        rs.close();
	    }

	    // Close the statement and connection
	    pstmt.close();
	    conn.close();

	    // Return the list of book titles corresponding to the book IDs
	    return bookTitles;
	}
	
	public double getTotalEarningsWithinDate(String startDate, String endDate) throws SQLException, ClassNotFoundException {
	  double grandTotal = 0.00;
	    
	    // Establish a database connection
	    Connection conn = DBConnection.getConnection();
	    
	    String sql = "SELECT SUM(total_price) as grandTotal FROM orders WHERE order_date BETWEEN ? AND ?";
	    PreparedStatement pstmt = conn.prepareStatement(sql);

	    pstmt.setString(1, startDate + " 00:00:00"); 
	    pstmt.setString(2, endDate + " 23:59:59");
	    
	    ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
           
            grandTotal = rs.getDouble("grandTotal");
        }

        
        rs.close();

	   
	    pstmt.close();
	    conn.close();

	    
	    return grandTotal;
	}
	
public double getTotalEarningForCustomer (ArrayList<Integer> orderIds) throws SQLException, ClassNotFoundException{
		
		String placeholders = String.join(",", Collections.nCopies(orderIds.size(), "?"));

		
		double grandTotal = 0.0;
		    
		    // Establish a database connection
		    Connection conn = DBConnection.getConnection();
		    
		    String sql = "SELECT SUM(total_price) AS grandTotal FROM orders WHERE order_id IN (" + placeholders + ")";
		    PreparedStatement pstmt = conn.prepareStatement(sql);
		   
		    for (int i = 0; i < orderIds.size(); i++) {
		        pstmt.setInt(i + 1, orderIds.get(i));
		    }
		    
		    ResultSet rs = pstmt.executeQuery();
		    
		    if (rs.next()) {
		        // Retrieve the data from each row
		         grandTotal = rs.getDouble("grandTotal");
		     
		    }
		    
		    // Close the result set, statement, and connection
		    rs.close();
		    pstmt.close();
		    conn.close();
		    
		   
		    return grandTotal;
		
	}

}
	

	
	
	
	
	


