<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<%

String username = (String) session.getAttribute("sessUsername");
String role = (String) session.getAttribute("sessRole");

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
<title>Add Book</title>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top p-3">
		<div class="container-fluid">
			<a class="navbar-brand" href="../user/home.jsp"><h1 class="store-name">LUNAR
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
						<li class="nav-item"><a class="nav-link"
							aria-current="page" href="../user/home.jsp">Home</a></li>
						<li class="nav-item"><a class="nav-link" href="../user/genres.jsp">Genres</a>
						</li>

						<%
						if (role != null) {
							if (role.equals("admin") || role.equals("owner")) {
								out.print("<li class='nav-item'><a class='nav-link active' href='addBook.jsp'>Add Book</a></li>");
								out.print("<li class='nav-item'><a class='nav-link' href='manageBook.jsp'>Manage Books</a></li>");
								out.print("<li class='nav-item'><a class='nav-link' href='removeMember.jsp'>Delete User</a></li>");
							}
						}
						%>

					</ul>


					<%
					if (role != null) {
						if (role.equals("admin") || role.equals("owner") || role.equals("member")) {
					%>
					
					<a href="../user/wishlist.jsp" class="text-white fw-light"
                ><button class="btn me-2" type="submit">
                <img src="../../imgs/wishlist.png" style="width: 28px; height: auto;">
                  <i class="fa-solid fa-book-heart fa-lg text-dark"></i></button 
              ></a>
					
					<a href="../user/cart.jsp" class="text-white fw-light"
                ><button class="btn me-4" type="submit">
                  <i class="fa-solid fa-cart-shopping fa-lg text-white mt-3"></i></button 
              ></a>

					<a href="../user/profilePage.jsp" class="text-white fw-light">
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
	
	<div
		class="container h-100 d-flex align-items-center justify-content-center">
		<div class="addBook-form mt-5 p-5">
			<h1 class="text-center">Add Book</h1>
			<form action="${pageContext.request.contextPath}/AddBookServlet" class="row g-4" method="POST"
enctype="multipart/form-data">
				<div class="col-md-12">
					<label for="title" class="form-label fw-light text-black">Title:</label>
					<input type="text" class="form-control" id="title" name="title">
				</div>

				<div class="col-md-6">
					<label for="author" class="form-label fw-light text-black">Author:</label>
					<input type="text" class="form-control" id="author" name="author">
				</div>

				<div class="col-md-6">
					<label for="publisher" class="form-label fw-light text-black">Publisher:</label>
					<input type="text" class="form-control" id="publisher"
						name="publisher">
				</div>

				<div class="col-md-6">
					<label for="price" class="form-label fw-light text-black">Price:</label>
					<input type="text" class="form-control" id="price" name="price">
				</div>

				<div class="col-md-6">
					<label for="quantity" class="form-label fw-light text-black">Quantity:</label>
					<input type="text" class="form-control" id="quantity"
						name="quantity">
				</div>

				<div class="col-md-6">
					<label for="publication_date"
						class="form-label fw-light text-black">Publication Date:</label> <input
						type="date" class="form-control" id="publication_date"
						name="publication_date">
				</div>

				<div class="col-md-6">
					<label for="isbn" class="form-label fw-light text-black">ISBN:</label>
					<input type="text" class="form-control" id="isbn" name="isbn">
				</div>

				<div class="col-md-6">
					<label for="genre" class="form-label fw-light text-black">Genre:</label>
					<select class="form-select" id="genre" name="genre">
						<option value="" selected disabled>Select Genre</option>
						<option value="Fantasy">Fantasy</option>
						<option value="Mystery">Mystery</option>
						<option value="Science Fiction">Science Fiction</option>
					</select>
				</div>

				<div class="col-md-6">
					<label for="rating" class="form-label fw-light text-black">Rating:</label>
					<input type="text" class="form-control" id="rating" name="rating">
				</div>

				<div class="col-md-12">
					<label for="description" class="form-label fw-light text-black">Description:</label>
					<textarea class="form-control" id="description" name="description"></textarea>
				</div>

				<div class="col-md-12">
					<label for="image_upload" class="form-label fw-light text-black">Image
						Upload:</label> <input type="file" class="form-control" id="image_upload"
						name="image_upload">
				</div>

				<div class="col-md-12">
					<input class="btn btn-primary btn-lg border-0 formBtns fw-light"
						type="submit" value="Add Book">
				</div>
			</form>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
		crossorigin="anonymous"></script>
</body>

</html>
