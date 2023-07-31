package servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CustomerInquiryDAO;

/**
 * Servlet implementation class DeleteInquiryServlet
 */
@WebServlet("/DeleteInquiryServlet")
public class DeleteInquiryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteInquiryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the inquiry ID from the request parameter
        String inquiryId = request.getParameter("id");

        if (inquiryId != null && !inquiryId.isEmpty()) {
            CustomerInquiryDAO inquiryDAO = new CustomerInquiryDAO();

            try {
                // Delete the inquiry from the database
                boolean isDeleted = inquiryDAO.deleteCustomerInquiry(Integer.parseInt(inquiryId));

                if (isDeleted) {
                    // Inquiry successfully deleted, redirect back to the viewInquiries.jsp page with a success message
                    response.sendRedirect(request.getContextPath() + "/jsp/admin/viewInquiry.jsp?deleteSuccess=true");
                } else {
                    // Failed to delete the inquiry, redirect back to the viewInquiries.jsp page with an error message
                    response.sendRedirect(request.getContextPath() + "/jsp/admin/viewInquiry.jsp?deleteError=true");
                }
            } catch (NumberFormatException | SQLException e) {
                ((Throwable) e).printStackTrace();
            }
        } else {
            // If inquiryId is null or empty, redirect back to the viewInquiries.jsp page with an error message
        	response.sendRedirect(request.getContextPath() + "/jsp/admin/viewInquiry.jsp?deleteError=true");
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
