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

import model.*;

/**
 * Servlet implementation class SalesInquiry
 */
@WebServlet("/SalesInquiry")
public class SalesInquiry extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SalesInquiry() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try {
            // Create a PaidOrderDAO instance
            PaidOrderDAO paidOrderDAO = new PaidOrderDAO();

            // Retrieve all paid orders for the user
            ArrayList<User> customerRanking = paidOrderDAO.getCustomerValueRanking();

            HttpSession session = request.getSession();
            session.setAttribute("customerRanking", customerRanking);

            // Forward the request to viewOrders.jsp
            request.getRequestDispatcher("jsp/admin/salesInquiry.jsp").forward(request, response);
            
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
