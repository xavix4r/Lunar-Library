package servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.*;
import java.util.ArrayList;

/**
 * Servlet implementation class viewOrders
 */
@WebServlet("/viewOrders")
public class viewOrders extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public viewOrders() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();

		int userId = (int) session.getAttribute("sessUserID");

	        try {
	            // Create a PaidOrderDAO instance
	            PaidOrderDAO paidOrderDAO = new PaidOrderDAO();

	            // Retrieve all paid orders for the user
	            ArrayList<PaidOrder> paidOrders = paidOrderDAO.getAllPaidOrders(userId);

	            // Set the paidOrders as an attribute in the request
	            request.setAttribute("paidOrders", paidOrders);

	            // Forward the request to viewOrders.jsp
	            request.getRequestDispatcher("jsp/user/viewOrders.jsp").forward(request, response);
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
