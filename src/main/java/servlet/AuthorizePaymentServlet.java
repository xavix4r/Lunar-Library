package servlet;
import java.io.IOException;
import model.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import com.paypal.base.rest.PayPalRESTException;

/**
 * Servlet implementation class AuthorizePaymentServlet
 */
@WebServlet("/AuthorizePaymentServlet")
public class AuthorizePaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuthorizePaymentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		
		ArrayList<String> bookTitles = (ArrayList<String>) session.getAttribute("bookTitles");
		ArrayList<Integer> amountToBuy = (ArrayList<Integer>) session.getAttribute("quantity");
		ArrayList<Double> bookPrice = (ArrayList<Double>) session.getAttribute("total");
		ArrayList<Integer> bookIds = (ArrayList<Integer>) session.getAttribute("bookIds");

		ArrayList<OrderDetails> allOrderDetails = new ArrayList<>();

		for (int i = 0; i < bookTitles.size(); i++) {
		    String title = bookTitles.get(i);
		    int quantity = amountToBuy.get(i);
		    double price = bookPrice.get(i);
		    int bookid = bookIds.get(i);
		    OrderDetails orderDetails = new OrderDetails(bookid, title, String.valueOf(quantity), String.valueOf(price));
		    allOrderDetails.add(orderDetails);
		}

		
		
		

		session.setAttribute("allOrderDetails", allOrderDetails);
		
        try {
        	int userId = (int) session.getAttribute("sessUserID");
        	User user = new User();
        	UserDAO userDAO = new UserDAO();
        	
        	user = userDAO.getFirstAndLastNameById(userId);
        	
        	String fname = user.getFirstName();
        	String lname = user.getLastName();
        	
        	
            PaymentServices paymentServices = new PaymentServices();
            String approvalLink = paymentServices.authorizePayment(allOrderDetails, fname, lname);
 
            response.sendRedirect(approvalLink);
             
        } catch (PayPalRESTException ex) {
            request.setAttribute("errorMessage", ex.getMessage());
            ex.printStackTrace();
            request.getRequestDispatcher("jsp/error.jsp").forward(request, response);
        } catch (Exception e) {
			System.out.print("Error: " + e);
		}
	}

}
