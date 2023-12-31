package servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.*;
import java.util.ArrayList;

/**
 * Servlet implementation class getBookByDate
 */
@WebServlet("/getBookByDate")
public class getBookByDate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public getBookByDate() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");

		String sortBy;
		String sortDirection;

		if (request.getParameter("sortOption") != null) {
			sortBy = request.getParameter("sortOption");
		} else {
			sortBy = "order_date"; // Default value
		}

		if (request.getParameter("sortDirection") != null) {
			sortDirection = request.getParameter("sortDirection");
		} else {
			sortDirection = "asc"; // Default value
		}

		try {

			PaidBookDAO paidBookDAO = new PaidBookDAO();
			PaidOrderDAO paidOrderDAO = new PaidOrderDAO();

			ArrayList<Integer> paidBookIds = paidBookDAO.getAllBookIdsByDate(startDate, endDate);

			ArrayList<PaidOrder> allPaidOrders = paidOrderDAO.getAllPaidOrdersAdmin(sortBy, sortDirection);

			if (paidBookIds.size() > 0) {
				double grandTotal = paidBookDAO.getTotalEarningsWithinDate(startDate, endDate);
				ArrayList<String> bookTitles = paidBookDAO.getBookTitlesByBookIds(paidBookIds);

				ArrayList<Integer> amountOrderedForEachBook = paidBookDAO.getAmountOrderedForPaidBooks(paidBookIds);

				HttpSession session = request.getSession();
				request.setAttribute("bookTitlesByDate", bookTitles);
				request.setAttribute("amountOrderedForEach", amountOrderedForEachBook);
				request.setAttribute("grandTotalDate", grandTotal);

			}

			else {
				request.setAttribute("nobookspurchased", true);
			}

			request.setAttribute("grandTotalCustomer", 0.00);
			request.setAttribute("allPaidOrdersAdmin", allPaidOrders);
			RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/admin/salesInquiry.jsp");
			dispatcher.forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			// Handle the SQL exception
			response.sendRedirect("jsp/error.jsp");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			// Handle the class not found exception
			response.sendRedirect("jsp/error.jsp");
		}

		catch (Exception e) {
			// Handle any exceptions
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

	}
}
