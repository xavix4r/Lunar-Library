
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DecimalFormat"%>

<%
String username = (String) session.getAttribute("sessUsername");
String role = (String) session.getAttribute("sessRole");
int userId = (int) session.getAttribute("sessUserID");

String address1 = "";
String address2 = "";

int postal = 0;


if (role == null || username == null) {
	response.sendRedirect(request.getContextPath() + "/user/login.jsp");
}

double totalAmount = 0;

ArrayList<Integer> bookIds = new ArrayList<>();
ArrayList<Integer> amountToBuy = new ArrayList<>();
ArrayList<String> bookTitles = new ArrayList<>();
ArrayList<Double> bookPrice = new ArrayList<>();

try {
	Class.forName("com.mysql.jdbc.Driver");
	String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
	Connection conn = DriverManager.getConnection(connURL);
	// Establish a database connection

	String cartQuery = "SELECT book_id, quantity FROM cart WHERE user_id = ?";
	PreparedStatement cartStmt = conn.prepareStatement(cartQuery);
	cartStmt.setInt(1, userId);
	ResultSet cartResultSet = cartStmt.executeQuery();

	// Retrieve book_ids from the cart table
	while (cartResultSet.next()) {
		int bookId = cartResultSet.getInt("book_id");
		int amount = cartResultSet.getInt("quantity");
		bookIds.add(bookId);
		amountToBuy.add(amount);

	}
	
	/* String addressSql = "SELECT address_line1, address_line2, postal FROM users_address WHERE user_id = ?";
	PreparedStatement addressStmt = conn.prepareStatement(addressSql);
	addressStmt.setInt(1, userId);

	ResultSet addressRs = addressStmt.executeQuery();

	if (addressRs.next()) {
		address1 = addressRs.getString("address_line1");
		address2 = addressRs.getString("address_line2");
		postal = addressRs.getInt("postal");
	} */
	
	cartResultSet.close();
	cartStmt.close();
	/* addressRs.close();
	addressStmt.close(); */
	conn.close();
} catch (Exception e) {
	e.printStackTrace();
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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styles.css" />
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Review Payment</title>

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
						<li class="nav-item"><a class="nav-link" aria-current="page"
							href="<%=request.getContextPath()%>/jsp/user/home.jsp">Home</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/jsp/user/genres.jsp">Genres</a></li>

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

					<a href="<%=request.getContextPath()%>/jsp/user/wishlist.jsp"
						class="text-white fw-light"><button class="btn me-2"
							type="submit">
							<img src="<%=request.getContextPath()%>/imgs/wishlist.png"
								style="width: 28px; height: auto;"> <i
								class="fa-solid fa-book-heart fa-lg text-dark"></i>
						</button></a> <a href="<%=request.getContextPath()%>/jsp/user/cart.jsp" class="text-white fw-light"><button
							class="btn me-4" type="submit">
							<i class="fa-solid fa-cart-shopping fa-lg text-white mt-3"></i>
						</button></a> <a href="<%=request.getContextPath()%>/jsp/user/profilePage.jsp"
						class="text-white fw-light">
						<button class="btn btn-success me-4" type="submit">
							<i class="fa-solid fa-user me-2"></i><%=username%>
						</button>
					</a>

					<form action="<%=request.getContextPath()%>/jsp/user/logout.jsp">
						<button class="btn btn-danger" type="submit">Logout</button>
					</form>

					<%
					} else if (role.equals("guest")) {
					%>

					<a href="<%=request.getContextPath()%>/jsp/user/login.jsp" class="text-white fw-light">
						<button class="btn btn-success me-4" type="submit">Login</button>
					</a> <a href="<%=request.getContextPath()%>/jsp/user/signUp.jsp" class="text-white fw-light">
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

		<h1 class="text-center pt-3">Review Payment Details</h1>

		<div class="row pt-5">

			<div class="col-md-6">
				<h3 class="pb-2 fw-bold">Payer Information</h3>
				<div class=" px-md-4 px-2 pt-3 pb-3 bg-white shadow-lg rounded-3">
					<label for="email" class="form-label">Email address:</label> <input
						type="email" class="form-control" id="email"
						value="${payer.email}" disabled> <label for="fname"
						class="form-label mt-3">First Name:</label> <input type="text"
						class="form-control" id="fname" value="${payer.firstName}"
						disabled> <label for="lname" class="form-label mt-3">Last
						Name:</label> <input type="text" class="form-control" id="lname"
						value="${payer.lastName}" disabled>

					<h3 class="mt-4">Shipping Address</h3>
					
					<!-- <div class="form-check mt-3">
                    <input class="form-check-input" type="radio" name="shipping" id="paypalShipping" checked>
                    <label class="form-check-label fw-bold" for="paypalShipping">
                      Use paypal shipping address
                    </label>
                  </div> -->

					<label for="address1" class="form-label mt-3">Address Line
						1:</label> <input type="text" class="form-control" id="address1"
						value="${shippingAddress.line1}" disabled> <label
						for="address2" class="form-label mt-3">Address Line 2:</label> <input
						type="text" class="form-control" id="address2"
						value="${shippingAddress.line2}" disabled> <label
						for="postal" class="form-label mt-3">Postal Code</label> <input
						type="number" class="form-control" id="postal"
						value="${shippingAddress.postalCode}" disabled>
						

				</div>


			</div>

			<div class="col-lg-6 payment-summary">
				<h3 class="fw-bold pt-lg-0 pt-4 pb-2">Payment Summary</h3>
				<div class="card px-md-3 px-2 pt-4 shadow-lg rounded-3 border-0">


					<div class="d-flex flex-column b-bottom">
						<div
							class="d-flex justify-content-between py-2 align-items-center">
							<h6 class="text-muted">Subtotal</h6>
							<h6 class="text-muted">$${transaction.amount.details.subtotal}
								SGD</h6>
						</div>
					</div>

					<div class="d-flex flex-column b-bottom">
						<div
							class="d-flex justify-content-between py-2 align-items-center">
							<h6 class="text-muted">Taxes (GST)</h6>
							<h6 class="text-muted">$${transaction.amount.details.tax}
								SGD</h6>
						</div>

					</div>

					<div class="d-flex flex-column b-bottom">
						<div
							class="d-flex justify-content-between py-2 align-items-center">
							<h4>Total</h4>
							<h5>$${transaction.amount.total} SGD</h5>
						</div>

					</div>






					<form
						action="ExecutePaymentServlet?paymentId=${param.paymentId}&payerId=${param.PayerID}&total=${transaction.amount.total}"
						method="post">
						<div class="d-grid gap-2">


							<button class="btn btn-primary mt-2 mb-3" type="submit">
								Confirm Payment $ ${transaction.amount.total}</button>

						</div>
					</form>
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
