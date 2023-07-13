package servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.AddressDAO;

/**
 * Servlet implementation class updateAddress
 */
@WebServlet("/updateAddress")
public class updateAddress extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public updateAddress() {
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
		int userId = Integer.parseInt(request.getParameter("userId"));
		String addressLine1 = request.getParameter("addressLine1");
		String addressLine2 = request.getParameter("addressLine2");
		int postalCode = Integer.parseInt(request.getParameter("postalCode"));

		// Create a UserDAO instance
		AddressDAO userDAO = new AddressDAO();

		try {
			// Insert the new address into the database
			int numRowsAffected = userDAO.updateAddress(userId, addressLine1, addressLine2, postalCode);

			if (numRowsAffected > 0) {
				// Address insertion successful
				response.sendRedirect("jsp/user/profilePage.jsp?success=1");
			} else {
				// Address insertion failed
				response.sendRedirect("jsp/userProfile/profilePage.jsp?error=1");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			// Handle the SQL exception
			response.sendRedirect("jsp/userProfile/profilePage.jsp?error=1");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			// Handle the class not found exception
			response.sendRedirect("jsp/userProfile/profilePage.jsp?error=1");
		}
	}

}
