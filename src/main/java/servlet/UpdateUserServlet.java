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
 * Servlet implementation class UpdateUserServlet
 */
@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateUserServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    int userId = Integer.parseInt(request.getParameter("userId"));
	    String firstName = request.getParameter("firstName");
	    String lastName = request.getParameter("lastName");
	    String email = request.getParameter("email");
	    String contactNumber = request.getParameter("contactNumber");
	    String addressLine1 = request.getParameter("addressLine1");
	    String addressLine2 = request.getParameter("addressLine2");
	    String postalParam = request.getParameter("postal");
	    Integer postal = null; // Default postal code if not provided or invalid

	    if (postalParam != null && !postalParam.isEmpty()) {
	        try {
	            postal = Integer.parseInt(postalParam);
	        } catch (NumberFormatException ex) {
	            ex.printStackTrace();
	            // Redirect back to manageMember.jsp with error message due to invalid postal code
	            response.sendRedirect(request.getContextPath() + "/jsp/admin/manageMember.jsp?updateError=true");
	            return;
	        }
	    }

	    UserDAO userDAO = new UserDAO();
	    try {
	        // Update user details
	        Address address = userDAO.getAddressByUserId(userId);
	        if (address == null) {
	            // If no address exists, create a new address object
	            address = new Address(userId, addressLine1, addressLine2, postal);
	        } else {
	            // If address exists, update the address object
	            address.setAddressLine1(addressLine1);
	            address.setAddressLine2(addressLine2);
	            if (postal != null) {
	                address.setPostal(postal.intValue()); 
	            }
	        }

	        // Update the user's address
	        userDAO.updateAddress(userId, address);
	        
	        
	        Address newAddress = new Address(userId, addressLine1, addressLine2, postal);
	        User updatedUser = new User(userId, null, firstName, lastName, null, email, null, contactNumber, newAddress);

	        userDAO.updateUser(updatedUser); // Call the method to update the user in the database
	        

	        // Update contact number
	        if (contactNumber != null && !contactNumber.isEmpty()) {
	            userDAO.updateContactNumber(userId, contactNumber);
	        }

	        // Redirect back to manageMember.jsp with success message
	        response.sendRedirect(request.getContextPath() + "/jsp/admin/manageMember.jsp?updateSuccess=true");
	    } catch (SQLException e) {
	        e.printStackTrace();
	        // Redirect back to manageMember.jsp with error message
	        response.sendRedirect(request.getContextPath() + "/jsp/admin/manageMember.jsp?updateError=true");
	    } catch (NullPointerException e) {
	        e.printStackTrace();
	        // Redirect back to manageMember.jsp with error message due to null postal code
	        response.sendRedirect(request.getContextPath() + "/jsp/admin/manageMember.jsp?updateError=true");
	    }
	}
}
