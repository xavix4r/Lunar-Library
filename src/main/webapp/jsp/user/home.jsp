<%@ page import="java.util.ArrayList" %>

<%



String username = (String) session.getAttribute("sessUsername");
String role = (String) session.getAttribute("sessRole");

if (role == null || username == null) {
	response.sendRedirect("login.jsp");
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
<title>Home</title>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


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
								out.print("<li class='nav-item'><a class='nav-link' href='../admin/addBook.jsp'>Add Book</a></li>");
								out.print("<li class='nav-item'><a class='nav-link' href='../admin/manageBook.jsp'>Manage Books</a></li>");
								out.print("<li class='nav-item'><a class='nav-link' href='../admin/removeMember.jsp'>Delete User</a></li>");
							}
						}
						%>



					</ul>


					<%
					if (role != null) {
						if (role.equals("admin") || role.equals("owner") || role.equals("member")) {
					%>
					
					<a href="wishlist.jsp" class="text-white fw-light"
                ><button class="btn me-2" type="submit">
                <img src="../../imgs/wishlist.png" style="width: 28px; height: auto;">
                  <i class="fa-solid fa-book-heart fa-lg text-dark"></i></button 
              ></a>
					
					<a href="cart.jsp" class="text-white fw-light"
                ><button class="btn me-4" type="submit">
                  <i class="fa-solid fa-cart-shopping fa-lg text-white mt-3"></i></button 
              ></a>
             

					<a href="profilePage.jsp" class="text-white fw-light">
						<button class="btn btn-success me-4" type="submit">
							
							<i class="fa-solid fa-user me-2"></i><%=username%>
						</button>
					</a>

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

	<div
		class="hero-image d-flex justify-content-center align-items-center p-5">
		<div class="row container w-100 mt-2 ">
			<div class="col-md-6 mt-2 d-flex justify-content-end">
				<img class="img-fluid me-5 astronaut" src="../../imgs/astronaut2.png"
					alt="astronaut" />
			</div>

			<div
				class="col-md-6 mt-2 d-flex justify-content-start align-items-start flex-column form">
				<h1 class="text-white hero-text">Embark on an interstellar
					Journey through the pages</h1>
							<div class="search mt-5 w-100">
					<form action="searchResults.jsp">
						<i class="fa fa-search"></i> <input type="text"
							class="form-control" name="search" placeholder="Search...">

						<select name="searchBy"
							class="form-select text-center border-3 border-primary rounded-5"
							id="search">
							<option value="title" class="text-start" selected>By
								Title</option>
							<option value="author" class="text-start">By Author</option>
						</select>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="container mt-4">
		<h1 class="text-center text-dark">Our Collection</h1>
		<div class="row mt-5 g-5 text-center">

			<%
			try {
				Class.forName("com.mysql.jdbc.Driver");
				String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
				Connection conn = DriverManager.getConnection(connURL);

				String sqlStr = "SELECT book_id, title, price, image_url FROM books;";
				PreparedStatement stmt = conn.prepareStatement(sqlStr);
				ResultSet rs = stmt.executeQuery();

				while (rs.next()) {
					int id = rs.getInt("book_id");
					String title = rs.getString("title");
					double price = rs.getDouble("price");
					String imageLocation = rs.getString("image_url");
			%>
			<div class="col-lg-4">
				<div class="card home-card p-3">
					<a href="bookDetails.jsp?bookId=<%=id%>"> <img
						src="<%=imageLocation%>" class="card-img-top" alt="...">
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

			conn.close();
			} catch (Exception e) {
			out.println("Error: " + e);
			}
			%>


		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
		crossorigin="anonymous"></script>
</body>
</html>

