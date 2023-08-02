
<%@page import="java.sql.*"%>
<%
String username = (String) session.getAttribute("sessUsername");
int userId = (int) session.getAttribute("sessUserID");
String fname = "";
String lname = "";
String email = "";
String contactNo = "";
String address1 = "";
String address2 = "";

int postal = 0;

String role = (String) session.getAttribute("sessRole");

if (role == null || username == null) {

	response.sendRedirect("login.jsp?isValidLogin=invalidLogin");
}

try {
	Class.forName("com.mysql.jdbc.Driver");
	String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
	Connection conn = DriverManager.getConnection(connURL);

	// Retrieve user's basic information
	String userSql = "SELECT * FROM users WHERE user_id = ?";
	PreparedStatement userStmt = conn.prepareStatement(userSql);
	userStmt.setInt(1, userId);

	ResultSet userRs = userStmt.executeQuery();

	if (userRs.next()) {
		fname = userRs.getString("fname");
		lname = userRs.getString("lname");
		email = userRs.getString("email");
	}

	// Retrieve user's contact information
	String contactSql = "SELECT contactNo FROM users_contact WHERE user_id = ?";
	PreparedStatement contactStmt = conn.prepareStatement(contactSql);
	contactStmt.setInt(1, userId);

	ResultSet contactRs = contactStmt.executeQuery();

	if (contactRs.next()) {
		contactNo = contactRs.getString("contactNo");
	}

	// Retrieve user's address information
	String addressSql = "SELECT address_line1, address_line2, postal FROM users_address WHERE user_id = ?";
	PreparedStatement addressStmt = conn.prepareStatement(addressSql);
	addressStmt.setInt(1, userId);

	ResultSet addressRs = addressStmt.executeQuery();

	if (addressRs.next()) {
		address1 = addressRs.getString("address_line1");
		address2 = addressRs.getString("address_line2");
		postal = addressRs.getInt("postal");
	}

	conn.close();
} catch (Exception e) {
	out.println("Error: " + e);
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
<title>Profile Page</title>

<%
String successParam = request.getParameter("success");
String errorParam = request.getParameter("error");

if (successParam != null && successParam.equals("1")) {
	// Show success alert for address update
%>
<script>
	alert("Address updated successfully!");
</script>
<%
} else if (successParam != null && successParam.equals("2")) {
// Show success alert for contact number update
%>
<script>
	alert("Contact number updated successfully!");
</script>
<%
} else if (errorParam != null && errorParam.equals("1")) {
// Show error alert for address update
%>
<script>
	alert("Error updating address. Please try again.");
</script>
<%
} else if (errorParam != null && errorParam.equals("2")) {
// Show error alert for contact number update
%>
<script>
	alert("Error updating contact number. Please try again.");
</script>
<%
}
%>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		$(".updateProfileBtn").click(function() {
			// Get the form data
			var formData = {
				fname : $("input[name=fname]").val(),
				lname : $("input[name=lname]").val(),
				email : $("input[name=email]").val()
			};

			// Check if any field is empty
			if (!formData.fname || !formData.lname || !formData.email) {
				alert("Please fill in all fields");
				return; // Stop further execution
			}

			// Check if email field contains "@"
			if (formData.email.indexOf("@") === -1) {
				alert("Invalid email address");
				return; // Stop further execution
			}

			// Execute AJAX request to update the member profile
			$.ajax({
				url : "updateMemberDetails.jsp",
				type : "POST",
				data : formData,
				success : function(response) {
					// Show success toast notification
					alert("Profile Updated Successfully");

				},
				error : function(xhr, status, error) {
					alert("Failed to update profile");
					// Handle the error, display error message, or perform any additional actions
				}
			});
		});

		$(".updatePasswordBtn").click(function(e) {

			// Get the form data
			var formData = {
				oldpw : $("input[name=oldpw]").val(),
				newpw : $("input[name=newpw]").val(),
				newpwconfirm : $("input[name=newpwconfirm]").val()
			};

			// Execute AJAX request to update the password
			$.ajax({
				url : "updatePassword.jsp",
				type : "POST",
				data : formData,
				success : function(response) {
					if (response.trim() === "success") {
						console.log(response)
						alert("Password updated successfully");

					} else {
						console.log(response)
						alert("Password doesn't match");
					}
				},
				error : function(xhr, status, error) {
					alert("Failed to update password");
					// Handle the error, display error message, or perform any additional actions
				}
			});
		});

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
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="home.jsp">Home</a></li>
						<li class="nav-item"><a class="nav-link" href="genres.jsp">Genres</a>
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
							href="<%=request.getContextPath()%>/jsp/admin/manageMember.jsp">Manage
								User</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/SalesInquiry">Sales
								Inquiry</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/jsp/admin/bookInquiry.jsp">Book
								Inquiry</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/ViewInquiriesServlet">Customer
								Inquiries</a></li>
						<%
						}
						}
						%>



					</ul>


					<%
					if (role != null) {
						if (role.equals("admin") || role.equals("owner") || role.equals("member")) {
					%>

					<a href="wishlist.jsp" class="text-white fw-light"><button
							class="btn me-2" type="submit">
							<img src="../../imgs/wishlist.png"
								style="width: 28px; height: auto;"> <i
								class="fa-solid fa-book-heart fa-lg text-dark"></i>
						</button></a> <a href="cart.jsp" class="text-white fw-light"><button
							class="btn me-4" type="submit">
							<i class="fa-solid fa-cart-shopping fa-lg text-white mt-3"></i>
						</button></a>


					<div class="dropdown me-2">
						<button class="btn btn-success dropdown-toggle text-white fw-bold"
							type="button" id="dropdownMenuButton" data-bs-toggle="dropdown"
							aria-expanded="false">
							<i class="fa-solid fa-user me-2"></i><%=username%>
						</button>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
							<li><a class="dropdown-item" href="profilePage.jsp">Profile</a></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/viewOrders">Orders</a></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/jsp/user/inquiryForm.jsp">Inquiry
									Form</a></li>

						</ul>
					</div>



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

	<div class="container w-75 my-5">
		<div class="container border-2 border-bottom p-2">
			<h4>My Profile</h4>
		</div>

		<div class="row my-5">
			<div class="col-lg-4">
				<div class="d-flex ms-3 flex-row align-items-center">
					<div
						class="d-flex justify-content-center align-items-center user-icon-container">
						<i class="fa-solid fa-user user-icon fa-5x"></i>
					</div>
					<h4 class="ms-3">
						@<%=username%></h4>
				</div>

				<div class="profile-nav mt-4">
					<div class="d-flex align-items-start">
						<div class="nav flex-column nav-pills me-3" id="v-pills-tab"
							role="tablist" aria-orientation="vertical">

							<button class="nav-link active" id="v-pills-profile-tab"
								data-bs-toggle="pill" data-bs-target="#v-pills-profile"
								type="button" role="tab" aria-controls="v-pills-profile"
								aria-selected="true">My Profile</button>
							<button class="nav-link" id="v-pills-edit-tab"
								data-bs-toggle="pill" data-bs-target="#v-pills-edit"
								type="button" role="tab" aria-controls="v-pills-edit"
								aria-selected="false">Edit Profile</button>

							<button class="nav-link" id="v-pills-password-tab"
								data-bs-toggle="pill" data-bs-target="#v-pills-password"
								type="button" role="tab" aria-controls="v-pills-password"
								aria-selected="false">Change Password</button>

							<button class="nav-link" id="v-pills-address-tab"
								data-bs-toggle="pill" data-bs-target="#v-pills-address"
								type="button" role="tab" aria-controls="v-pills-address"
								aria-selected="false">Edit Address</button>

							<button class="nav-link" id="v-pills-number-tab"
								data-bs-toggle="pill" data-bs-target="#v-pills-number"
								type="button" role="tab" aria-controls="v-pills-number"
								aria-selected="false">Edit Contact Number</button>
						</div>
					</div>
				</div>
			</div>

			<div class="col-lg-8">
				<div class="tab-content" id="v-pills-tabContent">
					<div class="tab-pane fade show active" id="v-pills-profile"
						role="tabpanel" aria-labelledby="v-pills-home-tab" tabindex="0">
						<h1>Personal Information</h1>

						<div class="row mt-3 g-4">
							<div class="col-lg-6">
								<div class="card rounded-3">
									<div class="card-body">
										<h5>Name</h5>
										<p class="text-muted"><%=fname%>
											<%=lname%></p>
									</div>
								</div>
							</div>

							<div class="col-lg-6">
								<div class="card">
									<div class="card-body">
										<h5>Email</h5>
										<p class="text-muted"><%=email%></p>
									</div>
								</div>
							</div>

							<div class="col-lg-12">
								<div class="card">
									<div class="card-body">
										<h5>Contact Number</h5>
										<%
										if (contactNo != null && !contactNo.isEmpty()) {
										%>
										<p class="text-muted"><%=contactNo%></p>
										<%
										} else {
										%>
										<a href="../userProfile/addContact.jsp">
											<button type="button" class="btn btn-outline-primary">
												<i class="fa-solid fa-plus"></i> Add Number
											</button>
										</a>
										<%
										}
										%>
									</div>
								</div>
							</div>



							<div class="col-lg-12">
								<div class="card">
									<div class="card-body">
										<h5>Shipping Address</h5>
										<%
										if (address1 != null && !address1.isEmpty()) {
										%>
										<h6 class="mt-3">Address Line 1</h6>
										<p class="text-muted"><%=address1%></p>
										<h6>Address Line 2</h6>
										<p class="text-muted"><%=address2%></p>
										<h6>Postal Code</h6>
										<p class="text-muted"><%=postal%></p>
										<%
										} else {
										%>
										<a href="../userProfile/addAddress.jsp">
											<button type="button" class="btn btn-outline-primary">
												<i class="fa-solid fa-plus"></i> Add Address
											</button>
										</a>
										<%
										}
										%>
									</div>
								</div>
							</div>



						</div>

					</div>


					<div class="tab-pane fade" id="v-pills-edit" role="tabpanel"
						aria-labelledby="v-pills-profile-tab" tabindex="0">
						<h1>Edit Profile</h1>

						<div class="row mt-3 g-3">
							<div class="col-lg-6">
								<label for="fname" class="form-label">First Name</label> <input
									type="text" name="fname" class="form-control"
									placeholder="First name" aria-label="First name">
							</div>
							<div class="col-lg-6">
								<label for="lname" class="form-label">Last Name</label> <input
									type="text" name="lname" class="form-control"
									placeholder="Last name" aria-label="Last name">
							</div>

							<div class="col-lg-12">
								<label for="email" class="form-label">Email</label> <input
									type="email" name="email" class="form-control"
									placeholder="Last name" aria-label="Last name">
							</div>

							<div class="col-lg-12">
								<input class="btn btn-primary border-0 " type="submit"
									value="Save Changes">
							</div>

						</div>
					</div>

					<div class="tab-pane fade" id="v-pills-password" role="tabpanel"
						aria-labelledby="v-pills-password-tab" tabindex="0">
						<h1>Change Password</h1>


						<div class="row mt-3 g-3">
							<div class="col-lg-12">
								<label for="oldpw" class="form-label">Old Password</label> <input
									type="password" name="oldpw" class="form-control"
									placeholder="Old Password" aria-label="Last name" required>
							</div>

							<div class="col-lg-12">
								<label for="newpw" class="form-label">New Password</label> <input
									type="password" name="newpw" class="form-control"
									placeholder="New Password" aria-label="Last name" required>
							</div>

							<div class="col-lg-12">
								<label for="newpwconfirm" class="form-label">Re-enter
									new password</label> <input type="password" name="newpwconfirm"
									class="form-control" placeholder="Re enter new password"
									aria-label="Last name" required>
							</div>

							<div class="col-lg-12">
								<input class="btn btn-primary border-0 updatePasswordBtn"
									type="submit" value="Update Password">
							</div>

						</div>

					</div>






					<div class="tab-pane fade" id="v-pills-address" role="tabpanel"
						aria-labelledby="v-pills-address-tab" tabindex="0">

						<h1>Edit Address</h1>

						<form
							action="<%=request.getContextPath()%>/updateAddress?userId=<%=userId%>"
							method="POST">
							<div class="row mt-3 g-3">

								<div class="col-lg-6">
									<label for="addressLine1" class="form-label">Address
										Line 1</label> <input type="text" name="addressLine1"
										class="form-control" placeholder="Enter address line 1"
										aria-label="addressLine1" required>
								</div>
								<div class="col-lg-6">
									<label for="addressLine2" class="form-label">Address
										Line 2</label> <input type="text" name="addressLine2"
										class="form-control" placeholder="Enter address line 2"
										aria-label="addressLine2">
								</div>

								<div class="col-lg-6">
									<label for="postalCode" class="form-label">Postal</label> <input
										type="text" name="postalCode" class="form-control"
										placeholder="Enter postal code" aria-label="postalCode"
										required>
								</div>

								<div class="col-lg-12">
									<button class="btn btn-primary border-0 " type="submit">Update
										Address</button>
								</div>


							</div>
						</form>

					</div>

					<div class="tab-pane fade" id="v-pills-number" role="tabpanel"
						aria-labelledby="v-pills-number-tab" tabindex="0">

						<h1>Edit Contact Number</h1>

						<form
							action="<%=request.getContextPath()%>/updateContact?userId=<%=userId%>"
							method="POST">
							<div class="row mt-3 g-3">

								<div class="col-lg-6">
									<label for="contact" class="form-label">Contact Number
									</label> <input type="text" name="contact" class="form-control"
										placeholder="Enter Contact Number" aria-label="contact"
										required>
								</div>


								<div class="col-lg-12">
									<button class="btn btn-primary border-0 " type="submit">Update
										Number</button>
								</div>


							</div>
						</form>

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
