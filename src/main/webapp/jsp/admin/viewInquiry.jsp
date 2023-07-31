<%@ page import="java.util.List"%>
<%@ page import="model.CustomerInquiry"%>
<%@ page import="model.CustomerInquiryDAO"%>

<%
String username = (String) session.getAttribute("sessUsername");
String role = (String) session.getAttribute("sessRole");

if (!"admin".equals(role) && !"owner".equals(role)) {
	response.sendRedirect("../user/login.jsp");
}
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700;800&display=swap"
	rel="stylesheet" />
<script src="https://kit.fontawesome.com/e1c5337441.js"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous" />
<link rel="stylesheet" type="text/css" href="../../css/styles.css" />
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<<<<<<< HEAD:src/main/webapp/jsp/admin/viewInquiry.jsp
<title>View Inquiries</title>
=======
<title>Add Book</title>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	function deleteMember(id) {
		console.log(id)
		$.ajax({
			url : "processMemberRemoval.jsp",
			type : "POST",
			data : {
				user_id : id
			},
			success : function(response) {
				console.log(response)
				alert("Successfully removed member");
				location.reload();
			},
			error : function(xhr, status, error) {
				alert("Failed to remove member");
			}
		});
	}
</script>

>>>>>>> 720830251e08dd568cccc24546d54fa269b81da9:src/main/webapp/jsp/admin/removeMember.jsp
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top p-3">
		<div class="container-fluid">
			<a class="navbar-brand" href="../user/home.jsp"><h1
					class="store-name">LUNAR LIBRARY</h1></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
				aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="offcanvas offcanvas-end bg-dark" tabindex="-1"
				id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
				<div class="offcanvas-header">
					<h5 class="offcanvas-title" id="offcanvasNavbarLabel"></h5>
					<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
						aria-label="Close"></button>
				</div>
				<div class="offcanvas-body">
					<ul
						class="navbar-nav justify-content-start align-items-center flex-grow-1 pe-3">
						<li class="nav-item"><a class="nav-link" aria-current="page"
							href="../user/home.jsp">Home</a></li>
						<li class="nav-item"><a class="nav-link"
							href="../user/genres.jsp">Genres</a></li>
						<%
						if (role != null) {
							if (role.equals("admin") || role.equals("owner")) {
						%>
<<<<<<< HEAD:src/main/webapp/jsp/admin/viewInquiry.jsp
						<li class="nav-item"><a class="nav-link" href="addBook.jsp">Add
								Book</a></li>
						<li class="nav-item"><a class="nav-link"
							href="manageBook.jsp">Manage Books</a></li>
						<li class="nav-item"><a class="nav-link"
							href="removeMember.jsp">Delete User</a></li>
=======
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/jsp/admin/addBook.jsp">Add
								Book</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/jsp/admin/manageBook.jsp">Manage
								Books</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/jsp/admin/removeMember.jsp">Delete
								User</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/SalesInquiry">Sales
								Inquiry</a></li>
>>>>>>> 720830251e08dd568cccc24546d54fa269b81da9:src/main/webapp/jsp/admin/removeMember.jsp
						<%
						}
						}
						%>
					</ul>
					<%
					if (role != null) {
						if (role.equals("admin") || role.equals("owner") || role.equals("member")) {
					%>
<<<<<<< HEAD:src/main/webapp/jsp/admin/viewInquiry.jsp
					<a href="../user/cart.jsp" class="text-white fw-light">
						<button class="btn me-4" type="submit">
							<i class="fa-solid fa-cart-shopping fa-lg text-white"></i>
						</button>
					</a> <a href="../user/profilePage.jsp" class="text-white fw-light">
						<button class="btn btn-success me-4" type="submit">
							<i class="fa-solid fa-user me-2"></i><%=username%>
						</button>
					</a>
=======

					<a href="../user/wishlist.jsp" class="text-white fw-light"><button
							class="btn me-2" type="submit">
							<img src="../../imgs/wishlist.png"
								style="width: 28px; height: auto;"> <i
								class="fa-solid fa-book-heart fa-lg text-dark"></i>
						</button></a> <a href="../user/cart.jsp" class="text-white fw-light"><button
							class="btn me-4" type="submit">
							<i class="fa-solid fa-cart-shopping fa-lg text-white mt-3"></i>
						</button></a>
					<div class="dropdown me-2">
						<button class="btn btn-success dropdown-toggle text-white fw-bold"
							type="button" id="dropdownMenuButton" data-bs-toggle="dropdown"
							aria-expanded="false">
							<i class="fa-solid fa-user me-2"></i><%=username%>
						</button>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
							<li><a class="dropdown-item" href="jsp/user/profilePage.jsp">Profile</a></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/viewOrders">Orders</a></li>
						</ul>
					</div>

>>>>>>> 720830251e08dd568cccc24546d54fa269b81da9:src/main/webapp/jsp/admin/removeMember.jsp
					<form action="../user/logout.jsp">
						<button class="btn btn-danger" type="submit">Logout</button>
					</form>
					<%
					} else if (role.equals("guest")) {
					%>
					<a href="../user/login.jsp" class="text-white fw-light">
						<button class="btn btn-success me-4" type="submit">Login</button>
					</a> <a href="../user/signUp.jsp" class="text-white fw-light">
						<button class="btn btn-dark" type="submit">Sign Up</button>
					</a>
					<%
					}
					}
					%>
				</div>
			</div>
		</div>
	</nav>

	<div class="container mt-5">
		<h1 class="text-center my-4">View Inquiries</h1>
		<table class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>#</th>
					<th>User ID</th>
					<th>Inquiry Type</th>
					<th>Inquiry Text</th>
					<th>Require Response</th>
					<th>Email</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<%
<<<<<<< HEAD:src/main/webapp/jsp/admin/viewInquiry.jsp
				CustomerInquiryDAO inquiryDAO = new CustomerInquiryDAO();
				List<CustomerInquiry> inquiries = inquiryDAO.getAllInquiries();
				int rowNum = 1;
				for (CustomerInquiry inquiry : inquiries) {
=======
				try {
					Class.forName("com.mysql.jdbc.Driver");
					String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
					Connection conn = DriverManager.getConnection(connURL);

					String sqlStr = "SELECT user_id, username, fname, lname, email FROM users WHERE role = ?;";
					PreparedStatement stmt = conn.prepareStatement(sqlStr);
					stmt.setString(1, "member");
					ResultSet rs = stmt.executeQuery();

					while (rs.next()) {
						int id = rs.getInt("user_id");
						String user = rs.getString("username");
						String fname = rs.getString("fname");
						String lname = rs.getString("lname");
						String email = rs.getString("email");
>>>>>>> 720830251e08dd568cccc24546d54fa269b81da9:src/main/webapp/jsp/admin/removeMember.jsp
				%>
				<tr>
					<td><%=rowNum++%></td>
					<td><%=inquiry.getUserId()%></td>
					<td><%=inquiry.getInquiryType()%></td>
					<td><%=inquiry.getInquiryText()%></td>
					<td><%=inquiry.isRequireResponse() ? "Yes" : "No"%></td>
					<td><%=inquiry.getEmail()%></td>
					<td>
						<%
						if (inquiry.isRequireResponse()) {
						%> <a
						href="mailto:<%=inquiry.getEmail()%>" class="btn btn-primary">Reply</a>
						<a
						href="${pageContext.request.contextPath}/DeleteInquiryServlet?id=<%= inquiry.getInquiryId() %>"
						class="btn btn-danger">Delete</a>
						<%
						} else {
						%> <a
						href="${pageContext.request.contextPath}/DeleteInquiryServlet?id=<%= inquiry.getInquiryId() %>"
						class="btn btn-danger">Delete</a> <%
 }
 %>
					</td>
				</tr>
				<%
				}
<<<<<<< HEAD:src/main/webapp/jsp/admin/viewInquiry.jsp
=======

				stmt.close();
				conn.close();
				} catch (Exception e) {
				out.println("Error: " + e);
				}
>>>>>>> 720830251e08dd568cccc24546d54fa269b81da9:src/main/webapp/jsp/admin/removeMember.jsp
				%>
			</tbody>
		</table>
	</div>
	
	<script>
        function displayAlertAndRemoveParams(message) {
            alert(message);
            // Remove the parameter from the URL after displaying the alert
            const urlWithoutParams = window.location.href.split('?')[0];
            window.history.replaceState({}, document.title, urlWithoutParams);
        }
    </script>
    
     <%-- Display success message if inquiry was successfully deleted --%>
    <%
    String deleteSuccess = request.getParameter("deleteSuccess");
    if (deleteSuccess != null && deleteSuccess.equals("true")) {
        %>
        <script>
            displayAlertAndRemoveParams("Inquiry deleted successfully.");
        </script>
    <% } %>

    <%-- Display error message if there was an error deleting the inquiry --%>
    <%
    String deleteError = request.getParameter("deleteError");
    if (deleteError != null && deleteError.equals("true")) {
        %>
        <script>
            displayAlertAndRemoveParams("Failed to delete inquiry.");
        </script>
    <% } %>
    
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-9nLAwpMNqCZRr8n4usjz40C7nK4lYnC4KnZaySf3h/UNiJ6Y9hmjg4vflSQK8wGd"
		crossorigin="anonymous"></script>
</body>
</html>
