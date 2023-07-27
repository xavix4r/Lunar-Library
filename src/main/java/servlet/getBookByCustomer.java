package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.*;

/**
 * Servlet implementation class getBookByCustomer
 */
@WebServlet("/getBookByCustomer")
public class getBookByCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getBookByCustomer() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		

		try {
			
			UserDAO userDAO = new UserDAO();
			
			int userid = userDAO.getUserIDByUsername(username);
			
			PaidOrderDAO paidOrderDAO = new PaidOrderDAO();
			
			ArrayList<Integer> allOrderIds = paidOrderDAO.getAllOrderIdsByUserid(userid);
			

			PaidBookDAO paidBookDAO = new PaidBookDAO();

			ArrayList<Integer> paidBookIds = paidBookDAO.getAllBookIdsByOrderId(allOrderIds);
			
			ArrayList<String> allBookTitles = paidBookDAO.getBookTitlesByBookIds(paidBookIds);

			ArrayList<Integer> amountOrderedForEachBook = paidBookDAO.getAmountOrderedForCustomer(allOrderIds);

			  HttpSession session = request.getSession();
	            session.setAttribute("bookTitlesCustomer", allBookTitles);
	            session.setAttribute("amountOrderedCustomer", amountOrderedForEachBook);

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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

}
