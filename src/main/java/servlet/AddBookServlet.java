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

@WebServlet("/AddBookServlet")
@MultipartConfig(location = "/org", fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class AddBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddBookServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	try {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String price = request.getParameter("price");
        String quantity = request.getParameter("quantity");
        String publisher = request.getParameter("publisher");
        String publication_date = request.getParameter("publication_date");
        String isbn = request.getParameter("isbn");
        String genre = request.getParameter("genre");
        String rating = request.getParameter("rating");
        String description = request.getParameter("description");
        String image_url = "";

        
        Part filePart = request.getPart("image_upload");
        if (filePart != null) {
        	String uploadDirectory = getServletContext().getRealPath("/imgs");
            String fileName = filePart.getSubmittedFileName();

            // Set the image URL to "../imgs/" + uniqueFileName
            image_url = "/imgs/" + fileName;

            
            String uploadPath = uploadDirectory + File.separator + fileName;

            // Save the uploaded file to the specified path
            filePart.write(uploadPath);
        }

        
            Class.forName("com.mysql.jdbc.Driver");
            String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
            Connection conn = DriverManager.getConnection(connURL);

            String sqlStr = "INSERT INTO books (title, author, price, quantity, publisher, publication_date, isbn, genre, rating, description, image_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sqlStr);
            stmt.setString(1, title);
            stmt.setString(2, author);
            stmt.setString(3, price);
            stmt.setString(4, quantity);
            stmt.setString(5, publisher);
            stmt.setString(6, publication_date);
            stmt.setString(7, isbn);
            stmt.setString(8, genre);
            stmt.setString(9, rating);
            stmt.setString(10, description);
            stmt.setString(11, image_url);

            int count = stmt.executeUpdate();

            if (count > 0) {
                response.getWriter().println("<script>alert('Book added successfully');</script>");
                response.getWriter().println("<script>window.location.href='../JADCA2/jsp/admin/addBook.jsp';</script>");
            } else {
                response.getWriter().println("<script>alert('Failed to add book');</script>");
                response.getWriter().println("<script>window.location.href='../JADCA2/jsp/admin/addBook.jsp';</script>");
            }

            conn.close();
        } catch (Exception e) {
            response.getWriter().println(e);
           
            e.printStackTrace();
        }
    }
}