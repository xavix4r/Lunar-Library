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
 * Servlet implementation class DeleteUserServlet
 */
@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteUserServlet() {
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

	    UserDAO userDAO = new UserDAO();
	    try {
	        // Delete user and related data from all tables
	        userDAO.deleteUserAndRelatedData(userId);

	        // Redirect back to manageMember.jsp with success message
	        response.sendRedirect(request.getContextPath() + "/jsp/admin/manageMember.jsp?deleteSuccess=true");
	    } catch (SQLException e) {
	        e.printStackTrace();
	        // Redirect back to manageMember.jsp with error message
	        response.sendRedirect(request.getContextPath() + "/jsp/admin/manageMember.jsp?deleteError=true");
	    }
	}
}
