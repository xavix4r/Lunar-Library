
<%

session.setAttribute("sessUsername", "guest");
session.setAttribute("sessRole", "guest");
session.setAttribute("sessUserID", 0);

String validLogin = request.getParameter("isValidLogin");
boolean isValidLogin = true;
if (validLogin != null && validLogin.equals("invalidLogin")) {

	isValidLogin = false;
}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<!DOCTYPE html>
<html lang="en">
<head>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700;800&display=swap"
	rel="stylesheet">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous" />
<link rel="stylesheet" type="text/css" href="../../css/login.css" />
<script
	src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Login</title>



</head>
<body>

	<h1 class="text-center text-white title mt-5">LUNAR LIBRARY</h1>
	<div
		class="container h-100 d-flex align-items-center justify-content-center">

		<div class="login-form mt-5 p-5">




			<%
			String invalidClass = ""; // Initialize the invalidClass variable

			if (!isValidLogin) {
				// Set the invalidClass when the login is invalid
				invalidClass = "border-2 border-danger";
			}
			%>
			<form action="verifyLogin.jsp" method="POST" class="row mt-3">
				<div class="col-md-6">
					<div class="animation">
						<lottie-player
							src="https://assets8.lottiefiles.com/packages/lf20_bqmgf5tx.json"
							background="transparent" speed="1"
							style="width: 300px; height: 300px" loop autoplay></lottie-player>
					</div>
				</div>

				<div class="col-md-6">
					<label for="username" class="form-label fw-light text-white">Username:</label>
					<input type="text" class="form-control <%=invalidClass%>"
						id="username" name="username"> <label for="pwd"
						class="form-label mt-3 fw-light text-white">Password:</label> <input
						type="password" class="form-control <%=invalidClass%>" id="pwd"
						name="pwd">

					<%
					if (!isValidLogin) {
						// Set the invalidClass when the login is invalid
						out.print("<h4 class = 'text-danger mt-3'>Invalid Username/Password</h4>");
					}
					%>

					<div class="d-grid gap-3 mt-4">
						<input class="btn btn-primary border-0 formBtns fw-light"
							type="submit" value="Login"> <a href="signUp.jsp"
							class="btn text-white fw-light">Sign Up</a> <a href="home.jsp"><h6
								class="text-white">Continue As Guest</h6></a>
					</div>
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
