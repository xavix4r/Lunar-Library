
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
		 <div class="row">

            <div class="col-md-8">
                <p class="pb-2 fw-bold">Order</p>
                <div class="table-responsive px-md-4 px-2 pt-3 bg-white shadow-lg rounded-3">
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
                      <tr class="align-middle border-bottom">
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
                      </tr>
            
                      <tr class="align-middle border-bottom">
                        <th scope="row">
                          <div class="d-flex align-items-center">
                            <img src="p102.jpg" class="img-fluid tableImage rounded-2" />
                            <div class="ms-4">
                              <h4>A Magic steeped in poison</h4>
                              <h5 class="text-muted">Fantasy</h5>
                            </div>
                          </div>
                        </th>
                        <td>$19.90</td>
                        <td><input type="number" name="quantity" min="1" max="100" value="1" class="form-control quantityNumber" disabled></td>
                        <td>$39.80 
                      </tr>
                      
                      
                    </tbody>
                    
                  </table>
                  </div>
            </div>

            <div class="col-lg-4 payment-summary">
                <p class="fw-bold pt-lg-0 pt-4 pb-2">Payment Summary</p>
                <div class="card px-md-3 px-2 pt-4 shadow-lg rounded-3 border-0">
                    
                    <div class="d-flex justify-content-between pb-3"> <small class="text-muted">Transaction code</small>
                        <p class="">VC115665</p>
                    </div>
                    <!-- <div class="d-flex justify-content-between b-bottom"> <input type="text" class="ps-2" placeholder="COUPON CODE">
                        <div class="btn btn-primary">Apply</div>
                    </div> -->
                    <div class="d-flex flex-column b-bottom">
                        <div class="d-flex justify-content-between py-3"> <small class="text-muted fw-bold">Grand Total w/o GST</small>
                            <p>$122</p>
                        </div>
                        
                        <div class="d-flex justify-content-between"> <small class="text-muted fw-bold">Grand Total incl. GST</small>
                            <p>$132</p>
                        </div>

                        <script data-sdk-integration-source="integrationbuilder_ac"></script>
                        <div id="paypal-button-container"></div>
                        <script src="https://www.paypal.com/sdk/js?client-id=AebHAvw_n6vlEBPPqSWaFLacIXzHw4Bq47gz4ffaKBTVw1ply1S18vVSPnDOpb-eEcPpl7Dgn6PnlJYo&components=buttons&enable-funding=venmo,paylater"></script>
                        <script>
                          const FUNDING_SOURCES = [
                            paypal.FUNDING.PAYPAL,
                            paypal.FUNDING.PAYLATER,
                            paypal.FUNDING.VENMO,
                            paypal.FUNDING.CARD,
                          ];
                    
                          FUNDING_SOURCES.forEach((fundingSource) => {
                            paypal
                              .Buttons({
                                fundingSource,
                                style: {
                                  layout: 'vertical',
                                  shape: 'rect',
                                  color: fundingSource === paypal.FUNDING.PAYLATER ? 'gold' : '',
                                },
                                createOrder: async (data, actions) => {
                                  try {
                                    const response = await fetch('http://localhost:9597/orders', {
                                      method: 'POST',
                                    });
                    
                                    const details = await response.json();
                                    return details.id;
                                  } catch (error) {
                                    console.error(error);
                                    // Handle the error or display an appropriate error message to the user
                                  }
                                },
                                onApprove: async (data, actions) => {
                                  try {
                                    const response = await fetch(
                                      `http://localhost:9597/orders/${data.orderID}/capture`,
                                      {
                                        method: 'POST',
                                      }
                                    );
                    
                                    const details = await response.json();
                                    // Three cases to handle:
                                    //   (1) Recoverable INSTRUMENT_DECLINED -> call actions.restart()
                                    //   (2) Other non-recoverable errors -> Show a failure message
                                    //   (3) Successful transaction -> Show confirmation or thank you message
                    
                                    // This example reads a v2/checkout/orders capture response, propagated from the server
                                    // You could use a different API or structure for your 'orderData'
                                    const errorDetail =
                                      Array.isArray(details.details) && details.details[0];
                    
                                    if (
                                      errorDetail &&
                                      errorDetail.issue === 'INSTRUMENT_DECLINED'
                                    ) {
                                      return actions.restart();
                                      // https://developer.paypal.com/docs/checkout/integration-features/funding-failure/
                                    }
                    
                                    if (errorDetail) {
                                      let msg = 'Sorry, your transaction could not be processed.';
                                      msg += errorDetail.description
                                        ? ' ' + errorDetail.description
                                        : '';
                                      msg += details.debug_id ? ' (' + details.debug_id + ')' : '';
                                      alert(msg);
                                    }
                    
                                    // Successful capture! For demo purposes:
                                    console.log(
                                      'Capture result',
                                      details,
                                      JSON.stringify(details, null, 2)
                                    );
                                    const transaction =
                                      details.purchase_units[0].payments.captures[0];
                                    alert(
                                      'Transaction ' +
                                        transaction.status +
                                        ': ' +
                                        transaction.id +
                                        'See console for all available details'
                                    );
                                  } catch (error) {
                                    console.error(error);
                                    // Handle the error or display an appropriate error message to the user
                                  }
                                },
                              })
                              .render('#paypal-button-container');
                          });
                        </script>
    

                    </div>
                   
                </div>
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
