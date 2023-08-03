<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%@ page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
String username = (String) session.getAttribute("sessUsername");
String role = (String) session.getAttribute("sessRole");

if (!"admin".equals(role) && !"owner".equals(role)) {
	response.sendRedirect(request.getContextPath() + "/jsp/user/login.jsp");
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700;800&display=swap"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/e1c5337441.js"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/styles.css" />
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
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
						<li class="nav-item"><a class="nav-link " aria-current="page"
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
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/jsp/admin/manageBook.jsp">Manage
								Books</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/jsp/admin/manageMember.jsp">Manage
								User</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/SalesInquiry">Sales
								Inquiry</a></li>
						<li class="nav-item"><a class="nav-link active"
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

	<div class="container my-5">
		<h1 class="text-center mb-4">Book Inquiry</h1>
		<form action="<%=request.getContextPath()%>/BookInquiryServlet"
			method="post" class="my-3">
			<div class="input-group mb-3">
				<input type="text" class="form-control"
					placeholder="Search Book Title" name="searchTitle" required>
				<button class="btn btn-primary" type="submit">Search</button>
			</div>
		</form>

		<div
			class="table-responsive px-md-4 px-2 pt-3 bg-white shadow-lg rounded-3">
			<table class="table table-borderless">
				<thead>
					<tr class="border-bottom">
						<th scope="col">Title</th>
						<th scope="col">Copies Sold</th>
						<th scope="col">Stocks Available</th>
					</tr>
				</thead>
				<tbody>
					<%
					ArrayList<BookRanking> searchResults = (ArrayList<BookRanking>) request.getAttribute("searchResults");
					String searchTitle = request.getParameter("searchTitle");

					if (searchResults != null && !searchResults.isEmpty()) {
						for (BookRanking bookRanking : searchResults) {
					%>
					<tr class="align-middle border-bottom">
						<td><%=bookRanking.getTitle()%></td>
						<td><%=bookRanking.getCopiesSold()%></td>
						<td><%=bookRanking.getQuantity()%></td>
					</tr>
					<%
					}
					} else if (searchTitle != null && !searchTitle.isEmpty()) {
					%>
					<tr>
						<td colspan="3" class="text-center">No matching books found</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</div>

	<div class="container my-5">
		<div class="row">
			<div class="col-md-6 mt-5">
				<h6>Best Selling Books</h6>
				<div
					class="table-responsive px-md-4 px-2 pt-3 bg-white shadow-lg rounded-3">
					<table class="table table-borderless">
						<thead>
							<tr class="border-bottom">
								<th scope="col">Title</th>
								<th scope="col">Copies Sold</th>
							</tr>
						</thead>
						<tbody>
							<%
							ArrayList<BookRanking> bestSellingBooks = new BookRankingDAO().getBestSellingBooks();
							if (bestSellingBooks != null && !bestSellingBooks.isEmpty()) {
								for (BookRanking bookRanking : bestSellingBooks) {
							%>
							<tr class="align-middle border-bottom">
								<td><%=bookRanking.getTitle()%></td>
								<td><%=bookRanking.getCopiesSold()%></td>
							</tr>
							<%
							}
							} else {
							%>
							<tr>
								<td colspan="2" class="text-center">No data available</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>

			<div class="col-md-6 mt-5">
				<h6>Least Sold Books</h6>
				<div
					class="table-responsive px-md-4 px-2 pt-3 bg-white shadow-lg rounded-3">
					<table class="table table-borderless">
						<thead>
							<tr class="border-bottom">
								<th scope="col">Title</th>
								<th scope="col">Copies Sold</th>
							</tr>
						</thead>
						<tbody>
							<%
							ArrayList<BookRanking> leastSellingBooks = new BookRankingDAO().getLeastSellingBooks();
							if (leastSellingBooks != null && !leastSellingBooks.isEmpty()) {
								for (BookRanking bookRanking : leastSellingBooks) {
							%>
							<tr class="align-middle border-bottom">
								<td><%=bookRanking.getTitle()%></td>
								<td><%=bookRanking.getCopiesSold()%></td>
							</tr>
							<%
							}
							} else {
							%>
							<tr>
								<td colspan="2" class="text-center">No data available</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>


			<div class="col-md-12 mt-5">
				<h6>Books with Low Stock Level</h6>
				<div
					class="table-responsive px-md-4 px-2 pt-3 bg-white shadow-lg rounded-3">
					<table class="table table-borderless">
						<thead>
							<tr class="border-bottom">
								<th scope="col">Title</th>
								<th scope="col">Stocks Available</th>
							</tr>
						</thead>
						<tbody>
							<%
							ArrayList<BookRanking> lowStockBooks = new BookRankingDAO().getLowStockBooks();
							if (lowStockBooks != null && !lowStockBooks.isEmpty()) {
								for (BookRanking bookRanking : lowStockBooks) {
							%>
							<tr class="align-middle border-bottom">
								<td><%=bookRanking.getTitle()%></td>
								<td><%=bookRanking.getQuantity()%></td>
							</tr>
							<%
							}
							} else {
							%>
							<tr>
								<td colspan="2" class="text-center">No books with low stock
									level</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
		crossorigin="anonymous"></script>
</body>
</html>

