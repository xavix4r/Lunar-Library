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

import model.PaidBook;
import model.PaidBookDAO;

/**
 * Servlet implementation class viewOrderDetails
 */
@WebServlet("/viewOrderDetails")
public class viewOrderDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public viewOrderDetails() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		

		
		int orderid = Integer.parseInt(request.getParameter("orderId"));


        try {
            // Create a PaidOrderDAO instance
           PaidBookDAO PaidBookDAO = new PaidBookDAO();
           
           ArrayList<Integer> paidBookIds = PaidBookDAO.getAllPaidBookIds(orderid);
           
           if(paidBookIds.size() > 0) {
        	   ArrayList<PaidBook> paidBookDetails = PaidBookDAO.getAllPaidBookDetails(paidBookIds, orderid);
        	   
        	   request.setAttribute("paidBookDetails", paidBookDetails);
           }
           

           
           

            
            request.getRequestDispatcher("jsp/user/orderDetails.jsp").forward(request, response);
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
