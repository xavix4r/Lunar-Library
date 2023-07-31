package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CustomerInquiry;
import model.CustomerInquiryDAO;

/**
 * Servlet implementation class ViewInquiriesServlet
 */
@WebServlet("/ViewInquiriesServlet")
public class ViewInquiriesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewInquiriesServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerInquiryDAO inquiryDAO = new CustomerInquiryDAO();
        try {
            List<CustomerInquiry> inquiries = inquiryDAO.getAllInquiries();
            request.setAttribute("inquiries", inquiries);
            request.getRequestDispatcher(request.getContextPath() + "/jsp/admin/viewInquiry.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the error and redirect to an error page if needed
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
