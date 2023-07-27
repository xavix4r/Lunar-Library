<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%@ page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
String username = (String) session.getAttribute("sessUsername");
String role = (String) session.getAttribute("sessRole");
int userId = (int) session.getAttribute("sessUserID");

if (!"admin".equals(role) && !"owner".equals(role)) {
	response.sendRedirect(request.getContextPath() + "/jsp/user/login.jsp");
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
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/styles.css" />
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Document</title>


<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<script>
	$(document).ready(
			function() {
				// Initialize date range picker
				$('#dateRangePicker')
						.daterangepicker(
								{
									opens : 'left', // Show the calendar on the left side of the input
									startDate : moment().subtract(7, 'days'), // Default start date (7 days ago)
									endDate : moment(), // Default end date (today)
									ranges : {
										'Last 7 Days' : [
												moment().subtract(6, 'days'),
												moment() ],
										'Last 30 Days' : [
												moment().subtract(29, 'days'),
												moment() ],
										'This Month' : [
												moment().startOf('month'),
												moment().endOf('month') ],
										'Last Month' : [
												moment().subtract(1, 'month')
														.startOf('month'),
												moment().subtract(1, 'month')
														.endOf('month') ]
									}
								});

				// Listen for changes in the date range picker and update hidden input fields
				$('#dateRangePicker').on(
						'apply.daterangepicker',
						function(ev, picker) {
							// Fetch the selected start and end dates
							var startDate = picker.startDate
									.format('YYYY-MM-DD');
							var endDate = picker.endDate.format('YYYY-MM-DD');

							// Set the values of the hidden input fields
							$('#startDate').val(startDate);
							$('#endDate').val(endDate);
						});

			});
</script>

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
						<li class="nav-item"><a class="nav-link "
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
							href="<%=request.getContextPath()%>/jsp/admin/removeMember.jsp">Delete
								User</a></li>
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
						</button></a> <a href="<%=request.getContextPath()%>/user/cart.jsp"
						class="text-white fw-light"><button class="btn me-4"
							type="submit">
							<i class="fa-solid fa-cart-shopping fa-lg text-white mt-3"></i>
						</button></a><a href="<%=request.getContextPath()%>/jsp/user/profilePage.jsp" class="text-white fw-light">
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
					</a> <a href="<%=request.getContextPath()%>/user/signUp.jsp" class="text-white fw-light">
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
		<div class="row">

			<div class="col-md-6 mt-4">
				<h6>Search Books Purchased by date</h6>

				<form action="<%=request.getContextPath()%>/getBookByDate"
					method="GET" id="searchForm" class="my-3 d-flex flex-column">
					<input type="hidden" name="startDate" id="startDate"> <input
						type="hidden" name="endDate" id="endDate"> <input
						type="text" class="form-control my-3" id="dateRangePicker">
					<input type="submit" class="btn btn-primary w-25" value="Search">
				</form>

				<div
					class="table-responsive px-md-4 px-2 pt-3 bg-white shadow-lg rounded-3">
					<table class="table table-borderless">
						<thead>
							<tr class="border-bottom">
								<th scope="col">Item</th>

								<th scope="col">Copies Sold</th>

							</tr>
						</thead>
						<tbody>

							<%
							ArrayList<String> titles = (ArrayList<String>) session.getAttribute("bookTitlesByDate");
							ArrayList<Integer> amountSold = (ArrayList<Integer>) session.getAttribute("amountOrderedForEach");

							if (titles != null && titles.size() > 0) {
								for (int i = 0; i < titles.size(); i++) {
									String title = titles.get(i);
									int quantityOrdered = amountSold.get(i);
							%>
							<tr class="align-middle border-bottom">
								<td><%=title%></td>
								<td><%=quantityOrdered%></td>
							</tr>
							<%
							}
							} else {
							%>
							<h2>Select a date range</h2>
							<%
							}
							%>

						</tbody>

					</table>
				</div>

			</div>

			<div class="col-md-6 mt-4">
				<h6>Search Customer that purchased certain books(Username)</h6>

				<form action="<%=request.getContextPath()%>/getBookByCustomer"
					method="GET" id="searchFormCust" class="my-3 d-flex flex-column">

					<input type="text" class="form-control my-3" name="username">
					<input type="submit" class="btn btn-primary w-25" value="Search">
				</form>

				<div
					class="table-responsive px-md-4 px-2 pt-3 bg-white shadow-lg rounded-3">
					<table class="table table-borderless">
						<thead>
							<tr class="border-bottom">
								<th scope="col">Item</th>

								<th scope="col">Copies Bought</th>

							</tr>
						</thead>
						<tbody>
							<%
							ArrayList<String> titlesCust = (ArrayList<String>) session.getAttribute("bookTitlesCustomer");
							ArrayList<Integer> amountSoldCust = (ArrayList<Integer>) session.getAttribute("amountOrderedCustomer");

							if (titlesCust != null && titlesCust.size() > 0) {
								for (int i = 0; i < titlesCust.size(); i++) {
									String titlecus = titlesCust.get(i);
									int quantityOrderedcus = amountSoldCust.get(i);
							%>
							<tr class="align-middle border-bottom">
								<td><%=titlecus%></td>
								<td><%=quantityOrderedcus%></td>
							</tr>
							<%
							}
							} else {
							%>
							<h2>Search Customer by Username</h2>
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