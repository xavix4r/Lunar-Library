package servlet;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;

/**
 * Servlet implementation class CustomerInquiryServlet
 */
@WebServlet("/CustomerInquiryServlet")
public class CustomerInquiryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CustomerInquiryServlet() {
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
		// Retrieve form data
		int userId = Integer.parseInt(request.getParameter("user_id"));
		String inquiryType = request.getParameter("inquiry_type");
		String inquiryText = request.getParameter("inquiry_text");
		boolean requireResponse = request.getParameter("require_response") != null;
		String email = "";

		if (requireResponse) {
			email = request.getParameter("email");
		}

		// Create a new CustomerInquiry object
		CustomerInquiry inquiry = new CustomerInquiry(userId, inquiryType, inquiryText, requireResponse, email);
		inquiry.setUserId(userId);
		inquiry.setInquiryType(inquiryType);
		inquiry.setInquiryText(inquiryText);
		inquiry.setRequireResponse(requireResponse);
		inquiry.setEmail(email);

		// Create a new CustomerInquiryDAO object
		CustomerInquiryDAO inquiryDAO = new CustomerInquiryDAO();

		try {
			// Save the inquiry to the database
			inquiryDAO.saveCustomerInquiry(inquiry);

			// Redirect back to the customer inquiry form with a success message
			response.sendRedirect(request.getContextPath() + "/jsp/user/inquiryForm.jsp?success=true");
		} catch (SQLException e) {
			e.printStackTrace();
			// Redirect back to the customer inquiry form with an error message
			response.sendRedirect(request.getContextPath() + "/jsp/user/inquiryForm.jsp?error=true");
		}
	}

}
