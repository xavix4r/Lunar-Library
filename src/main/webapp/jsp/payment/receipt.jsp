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
<title>Review Payment</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>

	<div class="container my-5 w-75">

		<div class=" px-md-4 px-2 pt-3 pb-3 bg-white shadow-lg rounded-3">

			<h1 class="text-center pt-3">Order Confirmed!</h1>
			<h2 class="text-center pt-3">Thanks for shopping at Lunar
				Library</h2>

			<div class="d-flex justify-content-center mt-3">
				<script
					src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
				<lottie-player
					src="https://assets6.lottiefiles.com/datafiles/8UjWgBkqvEF5jNoFcXV4sdJ6PXpS6DwF7cK4tzpi/Check Mark Success/Check Mark Success Data.json"
					background="transparent" speed="1"
					style="width: 200px; height: 200px;" class="me-4" autoplay></lottie-player>

				<div
					class="d-flex flex-column justify-content-center align-items-center ms-3">

					<h4>Paid: $${transaction.amount.total} SGD</h4>
					<a href = "<%=request.getContextPath()%>/viewOrders">
					<button class="btn btn-primary mt-3 w-100" type="submit">View
						Order</button></a>
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