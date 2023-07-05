<%@ page import="java.sql.*"%>
<%
String username = (String) session.getAttribute("sessUsername");
String role = (String) session.getAttribute("sessRole");

if (!"admin".equals(role) && !"owner".equals(role)) {
	response.sendRedirect("../user/login.jsp");
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
<title>Add Book</title>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	function deleteMember(id) {
		console.log(id)
		$.ajax({
			url : "processMemberRemoval.jsp",
			type : "POST",
			data : {
				user_id : id 
			},
			success : function(response) {
				console.log(response)
				alert("Successfully removed member");
				location.reload();
			},
			error : function(xhr, status, error) {
				alert("Failed to remove member");
			}
		});
	}
</script>

</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top p-3">
		<div class="container-fluid">
			<a class="navbar-brand" href="../user/home.jsp"><h1
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
							href="../user/home.jsp">Home</a></li>
						<li class="nav-item"><a class="nav-link"
							href="../user/genres.jsp">Genres</a></li>

						<%
						if (role != null) {
							if (role.equals("admin") || role.equals("owner")) {
								out.print("<li class='nav-item'><a class='nav-link' href='addBook.jsp'>Add Book</a></li>");
								out.print("<li class='nav-item'><a class='nav-link' href='manageBook.jsp'>Manage Books</a></li>");
								out.print("<li class='nav-item'><a class='nav-link active' href='removeMember.jsp'>Delete User</a></li>");
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
              ></a><a href="../user/profilePage.jsp" class="text-white fw-light">
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

	<div class="container my-5">
		<h1 class="text-center pt-4">Delete User</h1>

		<table class="table mt-3">
			<thead>
				<tr>
					<th scope="col">Name</th>
					<th scope="col">Username</th>
					<th scope="col">Email</th>
					<th scope="col"></th>
				</tr>
			</thead>
			<tbody>

				<!-- <tr class="align-middle">
            
            <td >John Doe</td>
            <td >johndoe</td>
            <td >johndoe@gmail.com</td>
            <td class = "text-center"><button class="btn btn-danger" type="submit">Delete</button></td>
           
          </tr> -->

				<%
				try {
					Class.forName("com.mysql.jdbc.Driver");
					String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
					Connection conn = DriverManager.getConnection(connURL);

					String sqlStr = "SELECT user_id, username, fname, lname, email FROM users WHERE role = ?;";
					PreparedStatement stmt = conn.prepareStatement(sqlStr);
					stmt.setString(1, "member");
					ResultSet rs = stmt.executeQuery();
					

					while (rs.next()) {
						int id = rs.getInt("user_id");
						String user = rs.getString("username");
						String fname = rs.getString("fname");
						String lname = rs.getString("lname");
						String email = rs.getString("email");
				%>
				<tr class="align-middle">

					<td><%=fname + lname%></td>
					<td><%=user%></td>
					<td><%=email%></td>

					<td class="text-center">
						<button class="btn btn-danger" type="button"
							onclick="deleteMember('<%=id%>')">Delete</button>
					</td>

				</tr>
				<%
				}
		
				stmt.close();
				conn.close();
				} catch (Exception e) {
				out.println("Error: " + e);
				}
				%>


			</tbody>

		</table>







	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
		crossorigin="anonymous"></script>
</body>
</html>
