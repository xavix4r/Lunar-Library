
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%@ page import="model.*"%>

<%
String username = (String) session.getAttribute("sessUsername");
String role = (String) session.getAttribute("sessRole");
int userId = (int) session.getAttribute("sessUserID");

if (role == null || username == null) {
	response.sendRedirect("login.jsp");
}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
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
<title>My Orders</title>

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
						</button></a> <a href="<%=request.getContextPath()%>/jsp/user/cart.jsp"
						class="text-white fw-light"><button class="btn me-4"
							type="submit">
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

					<a href="<%=request.getContextPath()%>/jsp/user/login.jsp"
						class="text-white fw-light">
						<button class="btn btn-success me-4" type="submit">Login</button>
					</a> <a href="<%=request.getContextPath()%>/jsp/user/signUp.jsp"
						class="text-white fw-light">
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
		<h5 class=" text-center pt-4">
			<a href="orders.html" class="link-underline-danger">Back to all
				orders</a>
		</h5>

		<div
			class="table-responsive px-md-4 mt-4 px-2 pt-3 bg-white shadow-lg rounded-3">
			<table class="table table-borderless">
				<thead>
					<tr class="border-bottom">
						<th scope="col">Item</th>
						<th scope="col">Price</th>
						<th scope="col">Quantity</th>
						<th scope="col">Total</th>
					</tr>
				</thead>
				<tbody>
					<!-- <tr class="align-middle border-bottom">
            <th scope="row">
              <div class="d-flex align-items-center mt-3">
                <img src="p101.jpg" class="img-fluid tableImage rounded-2" />
                <div class="ms-4">
                  <h4>The Fellowship of the Ring</h4>
                  <h5 class="text-muted">Fantasy</h5>
                </div>
              </div>
            </th>
            <td >$19.90</td>
            <td><input type="number" name="quantity" min="1" max="100" value="1" class="form-control quantityNumber" disabled></td>
            <td class="fw-bold">$39.80  
          </tr> -->

					<%
					ArrayList<PaidBook> paidBooks = (ArrayList<PaidBook>) request.getAttribute("paidBookDetails");
					if (paidBooks != null) {
						for (PaidBook book : paidBooks) {
					%>
					<tr class="align-middle border-bottom">
						<th scope="row">
							<div class="d-flex align-items-center mt-3">
								<img src="<%=request.getContextPath()%><%= book.getImgurl() %>" class="img-fluid tableImage rounded-2" />
								<div class="ms-4">
									<h4><%= book.getTitle() %></h4>
									<h5 class="text-muted"><%= book.getGenre() %></h5>
								</div>
							</div>
						</th>
						<td>$<%= book.getPriceStr() %></td>
						<td><input type="number" name="quantity" min="1" max="100"
							value="<%= book.getQuantityOrdered() %>" class="form-control quantityNumber" disabled></td>
						<td class="fw-bold">$<%= book.getTotalPaid() %>
					</tr>
					<%
					}
					} else {
						out.print("No Books");
					}
					%>




				</tbody>

			</table>
		</div>







		<div class=" d-flex justify-content-center mt-4">
			<a href="#">Keep Shopping</a>
		</div>


	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
		crossorigin="anonymous"></script>

</body>
</html>