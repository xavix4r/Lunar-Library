
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
%>
<%
response.setHeader("Pragma", "no-cache");
%>
<%
response.setDateHeader("Expires", 0);
%>


<%@ page import="java.sql.*"%>

<%
int userId = (int) session.getAttribute("sessUserID");
String username = (String) session.getAttribute("sessUsername");
String role = (String) session.getAttribute("sessRole");

if (role == null || username == null) {
	response.sendRedirect("login.jsp");
}

String idstr = request.getParameter("bookId");
int bookID = 0;
try {
	bookID = Integer.parseInt(idstr);
} catch (NumberFormatException e) {
	out.print(e);
}

boolean isInCart = false; // Assume it's not in the cart initially
boolean isInWishlist = false;

try {
	Class.forName("com.mysql.jdbc.Driver");
	String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
	Connection conn = DriverManager.getConnection(connURL);

	String cartQuery = "SELECT id FROM cart WHERE user_id = ? AND book_id = ?";
	PreparedStatement cartStatement = conn.prepareStatement(cartQuery);
	cartStatement.setInt(1, userId);
	cartStatement.setInt(2, bookID);
	ResultSet cartResult = cartStatement.executeQuery();

	if (cartResult.next()) {

		isInCart = true;
	}

	String wishlistQuery = "SELECT id FROM wishlist WHERE user_id = ? AND book_id = ?";
	PreparedStatement wishlistStatement = conn.prepareStatement(wishlistQuery);
	wishlistStatement.setInt(1, userId);
	wishlistStatement.setInt(2, bookID);
	ResultSet wishlistResult = wishlistStatement.executeQuery();

	if (wishlistResult.next()) {

		isInWishlist = true;
	}

	//Close the result set and prepared statement
	wishlistResult.close();
	wishlistStatement.close();

	//Close the result set and prepared statement
	cartResult.close();
	cartStatement.close();

} catch (Exception e) {
	out.println("Error: " + e);
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
<title>Book Details</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(document)
			.ready(
					function() {
						$("#addToCartBtn")
								.click(
										function() {
											var buttonText = $(this).text();

											if (buttonText.trim() === "Add To Cart") {

												$
														.ajax({
															url : "addCart.jsp",
															type : "POST",
															data : {
																bookId :
<%=bookID%>
	,
																amountToBuy : $(
																		"input[name='quantityToBuy']")
																		.val()
															},
															success : function(
																	response) {

																$(
																		"#addToCartBtn")
																		.text(
																				"Remove From Cart");
																$(
																		"#addToCartBtn")
																		.removeClass(
																				"btn-primary")
																		.addClass(
																				"btn-outline-primary");
																$(
																		"input[name='quantityToBuy']")
																		.prop(
																				"disabled",
																				true);
															}
														});
											} else if (buttonText.trim() === "Remove From Cart") {

												$
														.ajax({
															url : "removeCart.jsp",
															type : "POST",
															data : {
																bookId :
<%=bookID%>
	},
															success : function(
																	response) {
																// Update the button text and style
																$(
																		"#addToCartBtn")
																		.text(
																				"Add To Cart");
																$(
																		"#addToCartBtn")
																		.removeClass(
																				"btn-outline-primary")
																		.addClass(
																				"btn-primary");
																$(
																		"input[name='quantityToBuy']")
																		.prop(
																				"disabled",
																				false);
															}
														});
											}
										});

						$("#wishlistBtn")
								.click(
										function() {
											var text = $('.wishlistText')
													.text().trim();

											if (text === "Add To Wishlist") {

												$
														.ajax({
															url : "addWishlist.jsp",
															type : "POST",
															data : {
																bookId :
<%=bookID%>
	},
															success : function(
																	response) {

																$(
																		'.wishlistText')
																		.text(
																				"In Wishlist");
																$(".heartIcon")
																		.addClass(
																				"fa-solid")
																		.removeClass(
																				"fa-regular");
															}
														});

											} else if (text === "In Wishlist") {

												$
														.ajax({
															url : "removeWishlist.jsp",
															type : "POST",
															data : {
																bookId :
<%=bookID%>
	},
															success : function(
																	response) {

																$(
																		'.wishlistText')
																		.text(
																				"Add To Wishlist");
																$(".heartIcon")
																		.removeClass(
																				"fa-solid")
																		.addClass(
																				"fa-regular");
															}
														});

											}
										});

					});
</script>

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

	<div class="container pt-5 bg-light rounded-3">
		<div class="row mt-5 mb-5">

			<%
			try {
				Class.forName("com.mysql.jdbc.Driver");
				String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
				Connection conn = DriverManager.getConnection(connURL);

				String sqlStr = "SELECT * FROM books WHERE book_id = ?;";
				PreparedStatement stmt = conn.prepareStatement(sqlStr);
				stmt.setInt(1, bookID);

				ResultSet rs = stmt.executeQuery();

				if (rs.next()) {
					String image = rs.getString("image_url");
					String title = rs.getString("title");
					String author = rs.getString("author");
					String genre = rs.getString("genre");
					String description = rs.getString("description");
					String publisher = rs.getString("publisher");
					Date date = rs.getDate("publication_date");
					String isbn = rs.getString("isbn");
					Double rating = rs.getDouble("rating");
					int quantity = rs.getInt("quantity");
					double price = rs.getDouble("price");
			%>

			<div
				class="col-lg-6 d-flex justify-content-center border-3 border-end">
				<img src="<%=request.getContextPath()%><%=image%>"
					class="bookDetailsImage me-lg-5">
			</div>

			<div class="col-lg-6">
				<div class="container">


					<h1><%=title%></h1>

					<h2><%=author%></h2>
					<h4>
						Genre:
						<%=genre%></h4>
					<p class="mt-5 w-75"><%=description%>.
					</p>

					<h6 class="mt-5">
						Publisher:
						<%=publisher%>
					</h6>
					<h6>
						Publication Date:
						<%=date%>
					</h6>
					<h6>
						ISBN:
						<%=isbn%></h6>
					<h6>
						Rating:
						<%=rating%>/5
					</h6>
					<h6>
						In Stock:
						<%=quantity%></h6>

					<h1>
						$<%=price%></h1>

					<%
					if (!"guest".equals(role)) {
					%>

					<div class="d-flex flex-row mt-3">

						<input type="number" name="quantityToBuy" min="1"
							max="<%=quantity%>" value="1" class="form-control quantityNumber">
						<button id="addToCartBtn"
							class="btn <%=(isInCart ? "btn-outline-primary" : "btn-primary")%> ms-3"
							type="submit">
							<%=(isInCart ? "Remove From Cart" : "Add To Cart")%>
						</button>
					</div>

					<div class="d-flex text-muted mt-4 align-items-center">
						<h6 class="text-danger mt-2 wishlistText"><%=(isInWishlist ? "In Wishlist" : "Add To Wishlist")%>
						</h6>
						<button id="wishlistBtn" class="btn border-0">
							<i
								class="fa fa-regular fa-heart fa-2xl ms-2 text-danger heartIcon"></i>
						</button>
					</div>
					<%
					}
					%>



					<%
					} else {
					%>

					<h1>Book doesn't exist</h1>

					<%
					}

					rs.close();
					stmt.close();
					conn.close();
					} catch (Exception e) {
					out.print(e);
					}
					%>



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
