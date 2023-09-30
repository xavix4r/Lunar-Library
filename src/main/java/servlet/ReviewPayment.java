package servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
 
import com.paypal.api.payments.*;
import com.paypal.base.rest.PayPalRESTException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;

/**
 * Servlet implementation class ReviewPayment
 */
@WebServlet("/ReviewPayment")
public class ReviewPayment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewPayment() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 String paymentId = request.getParameter("paymentId");
	        String payerId = request.getParameter("PayerID");
	         
	        try {
	            PaymentServices paymentServices = new PaymentServices();
	            Payment payment = paymentServices.getPaymentDetails(paymentId);
	             
	            PayerInfo payerInfo = payment.getPayer().getPayerInfo();
	            Transaction transaction = payment.getTransactions().get(0);
	            ShippingAddress shippingAddress = transaction.getItemList().getShippingAddress();
	             
	            request.setAttribute("payer", payerInfo);
	            request.setAttribute("transaction", transaction);
	            request.setAttribute("shippingAddress", shippingAddress);
	             
	            String url = "jsp/payment/reviewPayment.jsp?paymentId=" + paymentId + "&PayerID=" + payerId;	
	             
	            request.getRequestDispatcher(url).forward(request, response);
	             
	        } catch (PayPalRESTException ex) {
	            request.setAttribute("errorMessage", ex.getMessage());
	            ex.printStackTrace();
	            request.getRequestDispatcher("jsp/error.jsp").forward(request, response);
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
