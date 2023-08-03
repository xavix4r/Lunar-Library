package servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class ProccessUpdateServlet
 */
@WebServlet("/ProccessUpdateServlet")
@MultipartConfig(location = "/org", fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class ProccessUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProccessUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 try {
	        	
	        	
	        	
	            int bookId = Integer.parseInt(request.getParameter("bookId"));
	            String title = request.getParameter("title");
	            String author = request.getParameter("author");
	            double price = Double.parseDouble(request.getParameter("price"));
	            int quantity = Integer.parseInt(request.getParameter("quantity"));
	            String publisher = request.getParameter("publisher");
	            String publicationDate = request.getParameter("publicationDate");
	            String isbn = request.getParameter("isbn");
	            String genre = request.getParameter("genre");
	            double rating = Double.parseDouble(request.getParameter("rating"));
	            String description = request.getParameter("description");
	            String image_url = "";

	            try {
	            
	            Part filePart = request.getPart("bookImage");
	            
	            
	            if (filePart != null) {
	                String uploadDirectory = getServletContext().getRealPath("/imgs");
	                String fileName = filePart.getSubmittedFileName();

	                
	                image_url = "/imgs/" + fileName;

	                String uploadPath = uploadDirectory + File.separator + fileName;

	                // Save the uploaded file to the specified path
	                filePart.write(uploadPath);
	            } 
	            
	            }catch(IOException e) {
	            	image_url = request.getParameter("existingImageURL");
	            }
	            

	            Class.forName("com.mysql.jdbc.Driver");
	            String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
	            Connection conn = DriverManager.getConnection(connURL);

	            String sqlStr = "UPDATE books SET title=?, author=?, price=?, quantity=?, publisher=?, publication_date=?, isbn=?, genre=?, rating=?, description=?, image_url=? WHERE book_id=?";
	            PreparedStatement stmt = conn.prepareStatement(sqlStr);
	            stmt.setString(1, title);
	            stmt.setString(2, author);
	            stmt.setDouble(3, price);
	            stmt.setInt(4, quantity);
	            stmt.setString(5, publisher);
	            stmt.setString(6, publicationDate);
	            stmt.setString(7, isbn);
	            stmt.setString(8, genre);
	            stmt.setDouble(9, rating);
	            stmt.setString(10, description);
	            stmt.setString(11, image_url);
	            stmt.setInt(12, bookId);

	            int rowsUpdated = stmt.executeUpdate();
	            
	            if (rowsUpdated > 0) {
	                response.getWriter().println("<script>alert('Book updated successfully');</script>");
	                response.getWriter().println("<script>window.location.href='../JADCA2/jsp/admin/manageBook.jsp';</script>");
	            } else {
	                response.getWriter().println("<script>alert('Failed to update book');</script>");
	                response.getWriter().println("<script>window.location.href='../JADCA2/jsp/admin/manageBook.jsp';</script>");
	            }

	            stmt.close();
	            conn.close();
	            
	        } catch (Exception e) {
	            response.sendRedirect("../JADCA2/jsp/admin/manageBook.jsp?updateResult=error");
	            e.printStackTrace();
	        }
	}

}
