
<%
String username = (String) session.getAttribute("sessUsername");
String role = (String) session.getAttribute("sessRole");

if (role == null || username == null) {
	response.sendRedirect("login.jsp");
}

String search = request.getParameter("search");
String searchBy = request.getParameter("searchBy");

if (searchBy == null && search == null) {
	response.sendRedirect("home.jsp");
}
%>
<%@ page import="java.sql.*"%>
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
<title>Search Results</title>
</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top p-3">
		<div class="container-fluid">
			<a class="navbar-brand" href="home.jsp"><h1 class="store-name">LUNAR
					LIBRARY</h1></a>
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
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="home.jsp">Home</a></li>
						<li class="nav-item"><a class="nav-link" href="genres.jsp">Genres</a>
						</li>

						<%
						if (role != null) {
							if (role.equals("admin") || role.equals("owner")) {
						%>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/jsp/admin/addBook.jsp">Add
								Book</a></li>
						<li class="nav-item"><a class="nav-link"
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

					<a href="wishlist.jsp" class="text-white fw-light"><button
							class="btn me-2" type="submit">
							<img src="../../imgs/wishlist.png"
								style="width: 28px; height: auto;"> <i
								class="fa-solid fa-book-heart fa-lg text-dark"></i>
						</button></a> <a href="cart.jsp" class="text-white fw-light"><button
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
							<li><a class="dropdown-item" href="profilePage.jsp">Profile</a></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/viewOrders">Orders</a></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/jsp/user/inquiryForm.jsp">Inquiry
									Form</a></li>

						</ul>
					</div>



					<form action="logout.jsp">
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

	<div class="container mt-5 mb-5 p-5 bg-light rounded-3">

		<%
		if (searchBy.equals("title")) {
		%>
		<h1 class="my-2 text-center text-dark">Search Results by Title</h1>
		<div class="row mt-5 mb-5 g-5 text-center">
			<%
			try {
				Class.forName("com.mysql.jdbc.Driver");
				String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
				Connection conn = DriverManager.getConnection(connURL);

				String sqlStr = "SELECT book_id, title, price, image_url FROM books WHERE locate(?, title);";
				PreparedStatement stmt = conn.prepareStatement(sqlStr);
				stmt.setString(1, search);

				ResultSet rs = stmt.executeQuery();
				boolean found = false;

				while (rs.next()) {
					int id = rs.getInt("book_id");
					String image = rs.getString("image_url");
					String title = rs.getString("title");
					double price = rs.getDouble("price");
					found = true;
			%>

			<div class="col-lg-4">
				<div class="card home-card p-3">
					<a href="bookDetails.jsp?bookId=<%=id%>"> <img src="<%=image%>"
						class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title"><%=title%></h5>
							<h5 class="card-title">
								$<%=price%></h5>
						</div>
					</a>
				</div>
			</div>

			<%
			}

			rs.close();
			stmt.close();
			conn.close();

			if (!found) {
			%>
			<div class="col-12">
				<h2>No books found with that title</h2>
			</div>
			<%
			}

			} catch (Exception e) {
			out.print(e);
			}
			} else if (searchBy.equals("author")) {
			%>
			<h1 class="my-2 text-center text-dark">Search Results by Author</h1>
			<div class="row mt-5 mb-5 g-5 text-center">
				<%
				try {
					Class.forName("com.mysql.jdbc.Driver");
					String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
					Connection conn = DriverManager.getConnection(connURL);

					String sqlStr = "SELECT book_id, title, price, image_url FROM books WHERE locate(?, author);";
					PreparedStatement stmt = conn.prepareStatement(sqlStr);
					stmt.setString(1, search);

					ResultSet rs = stmt.executeQuery();
					boolean found = false;

					while (rs.next()) {
						int id = rs.getInt("book_id");
						String image = rs.getString("image_url");
						String title = rs.getString("title");
						double price = rs.getDouble("price");
						found = true;
				%>

				<div class="col-lg-4">
					<div class="card home-card p-3">
						<a href="bookDetails.jsp?bookId=<%=id%>"> <img
							src="<%= request.getContextPath() %><%=image%>"
							class="card-img-top" alt="...">
							<div class="card-body">
								<h5 class="card-title"><%=title%></h5>
								<h5 class="card-title">
									$<%=price%></h5>
							</div>
						</a>
					</div>
				</div>

				<%
				}

				rs.close();
				stmt.close();
				conn.close();

				if (!found) {
				%>
				<div class="col-12">
					<h2>No books found with that author</h2>
				</div>
				<%
				}

				} catch (Exception e) {
				out.print(e);
				}
				}
				%>



			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
		crossorigin="anonymous"></script>
</body>
</html>
