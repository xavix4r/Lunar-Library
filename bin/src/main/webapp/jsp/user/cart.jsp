
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DecimalFormat" %>

<%
String username = (String) session.getAttribute("sessUsername");
String role = (String) session.getAttribute("sessRole");
int userId = (int) session.getAttribute("sessUserID");

if (role == null || username == null) {
	response.sendRedirect("login.jsp");
}


double totalAmount = 0;



ArrayList<Integer> bookIds = new ArrayList<>();
ArrayList<Integer> amountToBuy = new ArrayList<>();

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
	cartResultSet.close();
	cartStmt.close();
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
<link rel="stylesheet" type="text/css" href="../../css/styles.css" />
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Shopping Cart</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

	$(document).ready(function() {
		$(".removeItem").click(function() {
			var bookId = $(this).data("bookid");

			$.ajax({
				url : "removeCart.jsp",
				type : "POST",
				 data: { bookId: bookId },
				success : function(response) {
					// Update the cart page or perform any necessary actions
					// For example, you can reload the cart page to reflect the updated cart
					location.reload();
				},
				error : function() {
					alert("Failed to remove item from cart.");
				}
			});
		});
		
		$(".quantityNumber").on("change", function() {
	        // Get the current quantity value
	        var quantity = $(this).val();
	       
	        
	        // Get the book ID
	        var bookId = $(this).data("bookid");
	       
	        // Get the price of the book
	        var price = parseFloat($(this).closest("tr").find("td:nth-child(2)").text().replace("$", ""));
	        
	        // Calculate the new total amount
	        var total = (quantity * price).toFixed(2);
	        
	        // Update the total amount text
	        $(this).closest("tr").find(".total-amount").text(total);
	        
	        // Send AJAX request to update the cart in the database
	        $.ajax({
	            url: "updateCart.jsp",
	            type: "POST",
	            data: { bookId: bookId, amountToBuy: quantity },
	            success: function(response) {
	            	updateGrandTotal();
	            },
	            error: function(xhr, status, error) {
	            	alert("Failed to remove item from cart.");
	            }
	        });
	    });
		
		function updateGrandTotal() {
		    var grandTotal = 0;
		    
		    // Iterate over all the rows in the table
		    $(".quantityNumber").each(function() {
		        var quantity = $(this).val();
		        var price = parseFloat($(this).closest("tr").find("td:nth-child(2)").text().replace("$", ""));
		        
		        // Calculate the total amount for each row
		        var total = quantity * price;
		        
		        // Add the total to the grand total
		        grandTotal += total;
		    });
		    
		    // Update the grand total text
		    $(".grandTotal").text("Grand Total: $" + grandTotal.toFixed(2));
		}
		
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
						<li class="nav-item"><a class="nav-link"
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

	<div class="container my-5">
		<h1 class="text-center pt-4">
			My Shopping Cart
		</h1>

		<table class="table mt-3">
			<thead>
				<tr>
					<th scope="col">Item</th>
					<th scope="col">Price</th>
					<th scope="col">Quantity</th>
					<th scope="col">Total</th>
				</tr>
			</thead>
			<tbody>


				<%
				if (bookIds.isEmpty()) {
					out.println("<tr><td colspan='4'>No items in cart</td></tr>");
				} else {

					Class.forName("com.mysql.jdbc.Driver");
					String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
					Connection conn = DriverManager.getConnection(connURL);
					
					

					String bookQuery = "SELECT title, genre, price, image_url FROM books WHERE book_id = ?";
					PreparedStatement bookStmt = conn.prepareStatement(bookQuery);

					for (int i = 0; i < bookIds.size(); i++) {
						int bookId = bookIds.get(i);
						int amount = amountToBuy.get(i);
						bookStmt.setInt(1, bookId);
						ResultSet bookResultSet = bookStmt.executeQuery();

						if (bookResultSet.next()) {
					// Retrieve book details
					String title = bookResultSet.getString("title");
					String genre = bookResultSet.getString("genre");
					Double price = bookResultSet.getDouble("price");
					String imageurl = bookResultSet.getString("image_url");
					
					totalAmount += amount * price;
				%>

				<tr class="align-middle">
					<th scope="row">
						<div class="d-flex align-items-center">
							<img src="<%=imageurl%>" class="img-fluid tableImage" />
							<div class="ms-4">
								<h3><%=title%></h3>
								<h5 class="text-muted"><%=genre%></h5>
							</div>
						</div>
					</th>
					<td>$<%=price%></td>
					<td><input type="number" name="quantity" min="1" max="100"
						value="<%=amount%>" class="form-control quantityNumber" data-bookid="<%=bookId%>"></td>
					<td>$<span class="total-amount fw-bold"><%=amount * price%></span>
						<button class="text-decoration-none text-dark removeItem ms-2 border-0" data-bookid="<%=bookId%>">
							<i class="fa-regular fa-x fa-xs"></i>
						</button></td>
				</tr>

				<%
				}

				bookResultSet.close();
				}
				bookStmt.close();
				}
				%>

			</tbody>
		</table>



		<div class=" d-flex justify-content-center">
            <a href="home.jsp">Keep Shopping</a>
          </div>

          <div class="d-flex ms-auto justify-content-end flex-column w-25">
        <h1 class = "grandTotal">Grand Total: $<%= totalAmount %></h1>
        <button class="btn btn-primary mt-2" type="submit">Check Out</button>
    </div>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
		crossorigin="anonymous"></script>
</body>
</html>
