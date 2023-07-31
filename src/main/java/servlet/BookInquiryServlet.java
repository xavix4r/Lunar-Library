package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.BookRanking;
import model.BookRankingDAO;

@WebServlet("/BookInquiry")
public class BookInquiryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public BookInquiryServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Create a BookRankingDAO instance
            BookRankingDAO bookRankingDAO = new BookRankingDAO();

            // Retrieve the best selling books
            ArrayList<BookRanking> bestSellingBooks = bookRankingDAO.getBestSellingBooks();

            // Retrieve the least selling books
            ArrayList<BookRanking> leastSellingBooks = bookRankingDAO.getLeastSellingBooks();

            // Retrieve the low stock books
            ArrayList<BookRanking> lowStockBooks = bookRankingDAO.getLowStockBooks();

            HttpSession session = request.getSession();
            session.setAttribute("bestSellingBooks", bestSellingBooks);
            session.setAttribute("leastSellingBooks", leastSellingBooks);
            session.setAttribute("lowStockBooks", lowStockBooks); // Store low stock books in session

            // Forward the request to bookInquiry.jsp
            request.getRequestDispatcher("jsp/admin/bookInquiry.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the SQL exception
            response.sendRedirect("error.jsp");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            // Handle the class not found exception
            response.sendRedirect("error.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
