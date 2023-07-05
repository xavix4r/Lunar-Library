



<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%
String validRegister = request.getParameter("isValidRegister");
boolean isValidRegister = true;
if (validRegister != null && validRegister.equals("invalid")) {
%>
<script>
	alert("That username/email already exists");
</script>
<%
}
%>
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
<title>Sign Up</title>
</head>

<body>


	<div
		class="container h-100 d-flex align-items-center justify-content-center">

		<div class="signup-form mt-5 p-5">

			<h1 class="text-center">Sign Up</h1>



			<form action="addMember.jsp" class="row g-4" method="POST">

				<div class="col-md-6">
					<label for="fname" class="form-label fw-light text-white">First
						Name:</label> <input type="text" class="form-control" id="fname"
						name="fname">
				</div>

				<div class="col-md-6">
					<label for="lname" class="form-label fw-light text-white">Last
						Name:</label> <input type="text" class="form-control" id="lname"
						name="lname">
				</div>

				<div class="col-md-12">
					<label for="email" class="form-label fw-light text-white">Email
						Address:</label> <input type="email" class="form-control" id="email"
						name="email">
				</div>

				<div class="col-md-12">
					<label for="lname" class="form-label fw-light text-white">Username:</label>
					<input type="text" class="form-control" id="username"
						name="username">
				</div>

				<div class="col-md-12">
					<label for="lname" class="form-label fw-light text-white">Password:</label>
					<input type="password" class="form-control" id="pwd" name="pwd">
				</div>

				<div class="col-md-12">
					<input class="btn btn-primary btn-lg border-0 formBtns fw-light"
						type="submit" value="Create Account">
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