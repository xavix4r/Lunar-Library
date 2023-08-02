<%@ page import="java.util.ArrayList"%>

<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
String username = (String) session.getAttribute("sessUsername");
String role = (String) session.getAttribute("sessRole");
int userId = (int) session.getAttribute("sessUserID");

if (!"admin".equals(role) && !"owner".equals(role)) {
	response.sendRedirect("../user/login.jsp");
}
%>

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
<title>Document</title>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top p-3">
		<div class="container-fluid">
			<a class="navbar-brand"
				href="<%=request.getContextPath()%>/jsp/user/home.jsp"><h1
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
						<li class="nav-item"><a class="nav-link "
							aria-current="page"
							href="<%=request.getContextPath()%>/jsp/user/home.jsp">Home</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/jsp/user/genres.jsp">Genres</a>
						</li>

						<%
						if (role != null) {
							if (role.equals("admin") || role.equals("owner")) {
						%>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/jsp/admin/addBook.jsp">Add
								Book</a></li>
						<li class="nav-item"><a class="nav-link active"
							href="<%=request.getContextPath()%>/jsp/admin/manageBook.jsp">Manage
								Books</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/jsp/admin/manageMember.jsp">Manage
								User</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/SalesInquiry">Sales
								Inquiry</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/jsp/admin/bookInquiry.jsp">Book
								Inquiry</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/ViewInquiriesServlet">Customer
								Inquiries</a></li>
						<%
						}
						}
						%>



					</ul>


					<%
					if (role != null) {
						if (role.equals("admin") || role.equals("owner") || role.equals("member")) {
					%>

					<a href="<%=request.getContextPath()%>/jsp/user/wishlist.jsp"
						class="text-white fw-light"><button class="btn me-2"
							type="submit">
							<img src="<%=request.getContextPath()%>/imgs/wishlist.png"
								style="width: 28px; height: auto;"> <i
								class="fa-solid fa-book-heart fa-lg text-dark"></i>
						</button></a> <a href="<%=request.getContextPath()%>/jsp/user/cart.jsp"
						class="text-white fw-light"><button class="btn me-4"
							type="submit">
							<i class="fa-solid fa-cart-shopping fa-lg text-white mt-3"></i>
						</button></a>


					<div class="dropdown me-2">
						<button class="btn btn-success dropdown-toggle text-white fw-bold"
							type="button" id="dropdownMenuButton" data-bs-toggle="dropdown"
							aria-expanded="false">
							<i class="fa-solid fa-user me-2"></i><%=username%>
						</button>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/jsp/user/profilePage.jsp">Profile</a></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/viewOrders">Orders</a></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/jsp/user/inquiryForm.jsp">Inquiry
									Form</a></li>

						</ul>
					</div>



					<form action="<%=request.getContextPath()%>/jsp/user/logout.jsp">
						<button class="btn btn-danger" type="submit">Logout</button>
					</form>

					<%
					} else if (role.equals("guest")) {
					%>

					<a href="login.jsp" class="text-white fw-light">
						<button class="btn btn-success me-4" type="submit">Login</button>
					</a> <a href="signUp.jsp" class="text-white fw-light">
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

	<div class="manage-Books">
		<h1 class="text-center py-3">Manage Books</h1>

		<table class="books-table">
			<tr>

				<th>Title</th>
				<th>Author</th>
				<th>Price</th>
				<th>Publisher</th>
				<th>Quantity</th>
				<th>Publication Date</th>
				<th>ISBN</th>
				<th>Genre</th>
				<th>Rating</th>
				<th>Description</th>
				<th>Actions</th>
			</tr>
			<%
			try {
				Class.forName("com.mysql.jdbc.Driver");
				String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
				Connection conn = DriverManager.getConnection(connURL);

				String sqlStr = "SELECT * FROM books";
				PreparedStatement stmt = conn.prepareStatement(sqlStr);
				ResultSet rs = stmt.executeQuery();

				while (rs.next()) {
					int bookId = rs.getInt("book_id");
					String title = rs.getString("title");
					String author = rs.getString("author");
					double price = rs.getDouble("price");
					String publisher = rs.getString("publisher");
					int quantity = rs.getInt("quantity");
					String publicationDate = rs.getString("publication_date");
					String isbn = rs.getString("isbn");
					String genre = rs.getString("genre");
					double rating = rs.getDouble("rating");
					String description = rs.getString("description");
			%>
			<tr>

				<td><%=title%></td>
				<td><%=author%></td>
				<td><%=price%></td>
				<td><%=publisher%></td>
				<td><%=quantity%></td>
				<td><%=publicationDate%></td>
				<td><%=isbn%></td>
				<td><%=genre%></td>
				<td><%=rating%></td>
				<td><%=description%></td>
				<td><a href="updateBook.jsp?bookId=<%=bookId%>"
					class="btn-update">Update</a> <a
					href="deleteBook.jsp?bookId=<%=bookId%>" class="btn-delete mt-3">Delete</a>
				</td>
			</tr>
			<%
			}
			rs.close();
			stmt.close();
			conn.close();
			} catch (Exception e) {
			e.printStackTrace();
			}
			%>
		</table>

		<%
		String deleteResult = (String) request.getAttribute("deleteResult");
		if (deleteResult != null) {
		%>
		<script>
            alert("<%=deleteResult%>
			");
		</script>
		<%
		}
		%>

		<%
		String updateResult = request.getParameter("updateResult");
		if (updateResult != null) {
			if (updateResult.equals("success")) {
		%>
		<script>
			alert("Book details updated successfully.");
		</script>
		<%
		} else if (updateResult.equals("error")) {
		%>
		<script>
			alert("Failed to update book details.");
		</script>
		<%
		}
		}
		%>


	</div>
</body>
</html>