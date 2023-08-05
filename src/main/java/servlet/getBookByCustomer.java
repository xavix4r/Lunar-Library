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
			
			UserDAO userDAO = new UserDAO();
			PaidOrderDAO paidOrderDAO = new PaidOrderDAO();
			
			int userid = userDAO.getUserIDByUsername(username);
			
			ArrayList<PaidOrder> allPaidOrders = paidOrderDAO.getAllPaidOrdersAdmin(sortBy, sortDirection);
			
			if(userid > 0) {
				
				
				
				ArrayList<Integer> allOrderIds = paidOrderDAO.getAllOrderIdsByUserid(userid);
				
				if(allOrderIds.size() > 0) {
					
					PaidBookDAO paidBookDAO = new PaidBookDAO();

					ArrayList<Integer> paidBookIds = paidBookDAO.getAllBookIdsByOrderId(allOrderIds);
					
					ArrayList<String> allBookTitles = paidBookDAO.getBookTitlesByBookIds(paidBookIds);

					ArrayList<Integer> amountOrderedForEachBook = paidBookDAO.getAmountOrderedForCustomer(allOrderIds);
					
					double grandTotalCustomer = paidBookDAO.getTotalEarningForCustomer(allOrderIds);

					  HttpSession session = request.getSession();
			            request.setAttribute("bookTitlesCustomer", allBookTitles);
			            request.setAttribute("amountOrderedCustomer", amountOrderedForEachBook);
			            request.setAttribute("grandTotalCustomer", grandTotalCustomer);
			           
				}

				
				else if(allOrderIds.size() <= 0) {
					request.setAttribute("booknotfound", true);
				}
				
				
			}
			
			else if(userid <= 0) {
				request.setAttribute("usernotfound", true);
			}
			
			

			 request.setAttribute("grandTotalDate", 0.00);
				request.setAttribute("allPaidOrdersAdmin", allPaidOrders);
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
