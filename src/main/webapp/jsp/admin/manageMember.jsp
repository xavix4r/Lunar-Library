<%@ page import="java.sql.*"%>
<%@ page import="model.*"%>
<%
String username = (String) session.getAttribute("sessUsername");
String role = (String) session.getAttribute("sessRole");

if (!"admin".equals(role) && !"owner".equals(role)) {
	response.sendRedirect("../user/login.jsp");
}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
<title>Manage User</title>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>



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
								out.print("<li class='nav-item'><a class='nav-link' href='addBook.jsp'>Add Book</a></li>");
								out.print("<li class='nav-item'><a class='nav-link' href='manageBook.jsp'>Manage Books</a></li>");
								out.print("<li class='nav-item'><a class='nav-link active' href='manageMember.jsp'>Manage User</a></li>");
							}
						}
						%>

					</ul>


					<%
					if (role != null) {
						if (role.equals("admin") || role.equals("owner") || role.equals("member")) {
					%>

					<a href="../user/wishlist.jsp" class="text-white fw-light"><button
							class="btn me-2" type="submit">
							<img src="../../imgs/wishlist.png"
								style="width: 28px; height: auto;"> <i
								class="fa-solid fa-book-heart fa-lg text-dark"></i>
						</button></a> <a href="../user/cart.jsp" class="text-white fw-light"><button
							class="btn me-4" type="submit">
							<i class="fa-solid fa-cart-shopping fa-lg text-white mt-3"></i>
						</button></a><a href="../user/profilePage.jsp" class="text-white fw-light">
						<button class="btn btn-success me-4" type="submit">
							<i class="fa-solid fa-user me-2"></i><%=username%>
						</button>
					</a>

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

	<div class="container my-5">
		<h1 class="text-center pt-4">Manage User</h1>
		<form action="" method="post" class="my-3">
			<div class="input-group mb-3">
				<input type="text" class="form-control"
					placeholder="Search Username" name="searchUsername" required>
				<button class="btn btn-primary" type="submit">Search</button>
			</div>
		</form>

		<!-- Display user details for updating or deleting -->
		<%
		String searchUsername = request.getParameter("searchUsername");
		if (searchUsername != null) {
			UserDAO userDAO = new UserDAO();
			int userId = userDAO.getUserIDByUsername(searchUsername);

			if (userId != -1) {
				// User found, retrieve their details
				User user = userDAO.getUserById(userId);
				Address address = user.getAddress();
		%>
		<div class="updateUser">
			<form action="<%=request.getContextPath()%>/UpdateUserServlet"
				method="post">
				<input type="hidden" name="userId" value="<%=user.getUserId()%>">
				<div class="row">
					<div class="col-md-6 mb-3">
						<label for="firstName">First Name:</label> <input type="text"
							class="form-control" name="firstName"
							value="<%=user.getFirstName()%>" required>
					</div>
					<div class="col-md-6 mb-3">
						<label for="lastName">Last Name:</label> <input type="text"
							class="form-control" name="lastName"
							value="<%=user.getLastName()%>" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6 mb-3">
						<label for="email">Email:</label> <input type="email"
							class="form-control" name="email" value="<%=user.getEmail()%>"
							required>
					</div>
					<div class="col-md-6 mb-3">
						<label for="contactNumber">Contact Number:</label> <input
							type="tel" class="form-control" name="contactNumber"
							value="<%=user.getContactNumber() != null && !user.getContactNumber().equals("0") ? user.getContactNumber() : ""%>">
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 mb-3">
						<label for="addressLine1">Address Line 1:</label> <input
							type="text" class="form-control" name="addressLine1"
							value="<%= address != null && address.getAddressLine1() != null ? address.getAddressLine1() : "" %>">

					</div>
				</div>
				<div class="row">
					<div class="col-md-6 mb-3">
						<label for="addressLine2">Address Line 2:</label> <input
							type="text" class="form-control" name="addressLine2"
							value="<%= address != null && address.getAddressLine2() != null ? address.getAddressLine2() : "" %>">
					</div>

					<div class="col-md-6 mb-3">
						<label for="postal">Postal Code:</label> <input type="text"
							class="form-control" name="postal"
							value="<%=address != null ? (address.getPostal() != 0 ? address.getPostal() : "") : ""%>">

					</div>
				</div>
				<button type="submit" class="btn btn-primary">Update</button>
			</form>

			<form action="<%=request.getContextPath()%>/DeleteUserServlet"
				method="post">
				<input type="hidden" name="userId" value="<%=user.getUserId()%>">
				<button type="submit" class="btn btn-danger mt-2">Delete
					User</button>
			</form>
		</div>
		<%
		} else {
		%>
		<p class="text-danger">No such user exists.</p>
		<%
		}
		%>
		<%
		}
		%>
	</div>

	<script>
        function displayAlertAndRemoveParams(message, redirectUrl) {
            alert(message);
            // Remove the parameter from the URL after displaying the alert
            const urlWithoutParams = window.location.href.split('?')[0];
            window.history.replaceState({}, document.title, urlWithoutParams);
            // Redirect to the specified URL after the alert is closed
            window.location.href = redirectUrl;
        }
    </script>

    <%-- Display success message if user details were updated successfully --%>
    <%
    String updateSuccess = request.getParameter("updateSuccess");
    if (updateSuccess != null && updateSuccess.equals("true")) {
        %>
        <script>
            displayAlertAndRemoveParams("User details updated successfully.", "<%=request.getContextPath()%>/jsp/admin/manageMember.jsp");
        </script>
    <% } %>

    <%-- Display error message if there was an error updating user details --%>
    <%
    String updateError = request.getParameter("updateError");
    if (updateError != null && updateError.equals("true")) {
        %>
        <script>
            displayAlertAndRemoveParams("Failed to update user details.", "<%=request.getContextPath()%>/jsp/admin/manageMember.jsp");
        </script>
    <% } %>

    <%-- Display success message if user was deleted successfully --%>
    <%
    String deleteSuccess = request.getParameter("deleteSuccess");
    if (deleteSuccess != null && deleteSuccess.equals("true")) {
        %>
        <script>
            displayAlertAndRemoveParams("User deleted successfully.", "<%=request.getContextPath()%>/jsp/admin/manageMember.jsp");
        </script>
    <% } %>

    <%-- Display error message if there was an error deleting user --%>
    <%
    String deleteError = request.getParameter("deleteError");
    if (deleteError != null && deleteError.equals("true")) {
        %>
        <script>
            displayAlertAndRemoveParams("Failed to delete user.", "<%=request.getContextPath()%>/jsp/admin/manageMember.jsp");
        </script>
    <% } %>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
		crossorigin="anonymous"></script>
</body>
</html>