package servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.util.ArrayList;

import com.paypal.api.payments.*;
import com.paypal.base.rest.PayPalRESTException;
import model.*;

/**
 * Servlet implementation class ExecutePaymentServlet
 */
@WebServlet("/ExecutePaymentServlet")
public class ExecutePaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ExecutePaymentServlet() {
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
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String paymentId = request.getParameter("paymentId");
		String payerId = request.getParameter("payerId");
		/*String totalPriceStr = request.getParameter("total");*/
	/*	Double totalPrice = Double.parseDouble(totalPriceStr);*/
		int userId = (int) session.getAttribute("sessUserID");

		ArrayList<OrderDetails> allOrderDetails = (ArrayList<OrderDetails>) session.getAttribute("allOrderDetails");

		try {
			
			PaymentServices paymentServices = new PaymentServices();
            Payment payment = paymentServices.getPaymentDetails(paymentId);
             
            
            Transaction transaction = payment.getTransactions().get(0);
            ShippingAddress shippingAddress = transaction.getItemList().getShippingAddress();
			
			OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
			int orderid = orderDetailsDAO.insertOrder(userId, Double.parseDouble(transaction.getAmount().getTotal()));

			if (orderid > 0) {
				
				int nrowAffectedOrderItems = orderDetailsDAO.insertOrderItemsAndUpdateBooks(orderid, allOrderDetails);
				
				if(nrowAffectedOrderItems > 0) {
					int nrowAffectedOrderAddress = orderDetailsDAO.insertOrderAddress(orderid, shippingAddress.getLine1(), shippingAddress.getLine2(), Integer.parseInt(shippingAddress.getPostalCode()));
				}
			
			} else {
				response.sendRedirect("jsp/error.jsp");

			}
		} catch (SQLException e) {
			e.printStackTrace();
			// Handle the SQL exception
			// ...
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			// Handle the class not found exception
			// ...
		} catch (PayPalRESTException ex) {
			request.setAttribute("errorMessage", ex.getMessage());
			ex.printStackTrace();
			request.getRequestDispatcher("jsp/error.jsp").forward(request, response);
		}

		try {
			PaymentServices paymentServices = new PaymentServices();
			Payment payment = paymentServices.executePayment(paymentId, payerId);

			PayerInfo payerInfo = payment.getPayer().getPayerInfo();
			Transaction transaction = payment.getTransactions().get(0);

			request.setAttribute("payer", payerInfo);
			request.setAttribute("transaction", transaction);

			request.getRequestDispatcher("jsp/payment/receipt.jsp").forward(request, response);

		} catch (PayPalRESTException ex) {
			request.setAttribute("errorMessage", ex.getMessage());
			ex.printStackTrace();
			request.getRequestDispatcher("jsp/error.jsp").forward(request, response);
		}
	}

}
