package model;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
	
	
	
	

}
