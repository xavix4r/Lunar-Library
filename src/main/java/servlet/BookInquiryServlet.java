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

@WebServlet("/BookInquiryServlet")
public class BookInquiryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public BookInquiryServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String searchTitle = request.getParameter("searchTitle");
			BookRankingDAO bookRankingDAO = new BookRankingDAO(); // Create an instance of BookRankingDAO

			if (searchTitle != null && !searchTitle.isEmpty()) {
				// Perform book search based on the searchTitle
				ArrayList<BookRanking> searchResults = bookRankingDAO.searchBooksByTitle(searchTitle);

				request.setAttribute("searchResults", searchResults);

				// Forward the request to bookInquiry.jsp
				request.getRequestDispatcher("jsp/admin/bookInquiry.jsp").forward(request, response);
			} else {
				// Load the initial page with best-selling, least-selling, and low-stock books
				ArrayList<BookRanking> bestSellingBooks = bookRankingDAO.getBestSellingBooks();
				ArrayList<BookRanking> leastSellingBooks = bookRankingDAO.getLeastSellingBooks();
				ArrayList<BookRanking> lowStockBooks = bookRankingDAO.getLowStockBooks();

				HttpSession session = request.getSession();
				session.setAttribute("bestSellingBooks", bestSellingBooks);
				session.setAttribute("leastSellingBooks", leastSellingBooks);
				session.setAttribute("lowStockBooks", lowStockBooks);

				// Forward the request to bookInquiry.jsp
				request.getRequestDispatcher("jsp/admin/bookInquiry.jsp").forward(request, response);
			}
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
