<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>

<%
String username = (String) session.getAttribute("sessUsername");
String role = (String) session.getAttribute("sessRole");

if (!"admin".equals(role) && !"owner".equals(role)) {
	response.sendRedirect("../user/login.jsp");
}

// Get the book ID from the parameter
int bookId = Integer.parseInt(request.getParameter("bookId"));

// Establish the database connection
Class.forName("com.mysql.jdbc.Driver");
String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
Connection conn = DriverManager.getConnection(connURL);

// Query the database to retrieve the book details
String query = "SELECT * FROM books WHERE book_id = ?";
PreparedStatement statement = conn.prepareStatement(query);
statement.setInt(1, bookId);
ResultSet resultSet = statement.executeQuery();

// Check if a matching book was found
if (resultSet.next()) {
	// Retrieve the book details from the result set
	String title = resultSet.getString("title");
	String author = resultSet.getString("author");
	double price = resultSet.getDouble("price");
	String publisher = resultSet.getString("publisher");
	int quantity = resultSet.getInt("quantity");
	String publicationDate = resultSet.getString("publication_date");
	String isbn = resultSet.getString("isbn");
	String genre = resultSet.getString("genre");
	double rating = resultSet.getDouble("rating");
	String description = resultSet.getString("description");
	String image_url = resultSet.getString("image_url");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700;800&display=swap" rel="stylesheet" />
  <script src="https://kit.fontawesome.com/e1c5337441.js" crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous" />
  <link rel="stylesheet" type="text/css" href="../../css/styles.css" />
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Update Book</title>
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
								out.print("<li class='nav-item'><a class='nav-link' href='addBook.jsp'>Add Book</a></li>");
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
					
					<a href="../user/cart.jsp" class="text-white fw-light"
                ><button class="btn me-4" type="submit">
                  <i class="fa-solid fa-cart-shopping fa-lg text-white"></i></button 
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

<div class="updateBook">
    <h1 class="text-center py-3">Update Book</h1>
    <form action="${pageContext.request.contextPath}/ProcessUpdateServlet?existingImageURL=<%= image_url %>" method="POST" enctype="multipart/form-data">
      <input type="hidden" name="bookId" value="<%=bookId%>">
      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="title" class="form-label">Title:</label>
          <input type="text" class="form-control" id="title" name="title" value="<%=title%>">
        </div>
        <div class="col-md-6 mb-3">
          <label for="author" class="form-label">Author:</label>
          <input type="text" class="form-control" id="author" name="author" value="<%=author%>">
        </div>
      </div>
      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="publisher" class="form-label">Publisher:</label>
          <input type="text" class="form-control" id="publisher" name="publisher" value="<%=publisher%>">
        </div>
        <div class="col-md-6 mb-3">
          <label for="price" class="form-label">Price:</label>
          <input type="text" class="form-control" id="price" name="price" value="<%=price%>">
        </div>
      </div>
      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="quantity" class="form-label">Quantity:</label>
          <input type="text" class="form-control" id="quantity" name="quantity" value="<%=quantity%>">
        </div>
        <div class="col-md-6 mb-3">
          <label for="publicationDate" class="form-label">Publication Date:</label>
          <input type="text" class="form-control" id="publicationDate" name="publicationDate" value="<%=publicationDate%>">
        </div>
      </div>
      <div class="row">
        <div class="col-md-4 mb-3">
          <label for="isbn" class="form-label">ISBN:</label>
          <input type="text" class="form-control" id="isbn" name="isbn" value="<%=isbn%>">
        </div>
        <div class="col-md-4 mb-3">
          <label for="genre" class="form-label">Genre:</label>
          <input type="text" class="form-control" id="genre" name="genre" value="<%=genre%>">
        </div>
        <div class="col-md-4 mb-3">
          <label for="rating" class="form-label">Rating:</label>
          <input type="text" class="form-control" id="rating" name="rating" value="<%=rating%>">
        </div>
      </div>
      <div class="row">
        <div class="col-md-12 mb-3">
          <label for="description" class="form-label">Description:</label>
          <textarea class="form-control" id="description" name="description"><%=description%></textarea>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12 mb-3">
          <label for="bookImage" class="form-label">New Book Image:</label>
          <input type="file" class="form-control" id="bookImage" name="bookImage">
        </div>
      </div>
      <input type="submit" class="btn btn-primary" value="Update Book">
    </form>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-9nLAwpMNqCZRr8n4usjz40C7nK4lYnC4KnZaySf3h/UNiJ6Y9hmjg4vflSQK8wGd"
    crossorigin="anonymous"></script>
</body>
</html>
<%
} else {
    // No matching book found
    response.sendRedirect("manageBook.jsp");
}

// Close the database connection
resultSet.close();
statement.close();
conn.close();
%>
