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

		try {

			PaidBookDAO paidBookDAO = new PaidBookDAO();

			ArrayList<Integer> paidBookIds = paidBookDAO.getAllBookIdsByDate(startDate, endDate);

			// Get the list of book titles corresponding to the book IDs
			ArrayList<String> bookTitles = paidBookDAO.getBookTitlesByBookIds(paidBookIds);

			ArrayList<Integer> amountOrderedForEachBook = paidBookDAO.getAmountOrderedForPaidBooks(paidBookIds);

			HttpSession session = request.getSession();
            session.setAttribute("bookTitlesByDate", bookTitles);
            session.setAttribute("amountOrderedForEach", amountOrderedForEachBook);

			// Dispatch to the JSP page to display the updated data
			RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/admin/salesInquiry.jsp");
			dispatcher.forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			// Handle the SQL exception
			response.sendRedirect("error.jsp");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			// Handle the class not found exception
			response.sendRedirect("error.jsp");
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
