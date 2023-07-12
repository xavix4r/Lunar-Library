<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

 <div class="container my-5">
      <h5 class=" text-center pt-4"><a href = "orders.html" class="link-underline-danger">Back to all orders</a></h5>

      <div class="table-responsive px-md-4 mt-4 px-2 pt-3 bg-white shadow-lg rounded-3">
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

         
          
          
        </tbody>
        
      </table>
      </div>
      

    

      
        

          <div class=" d-flex justify-content-center mt-4">
            <a href="#">Keep Shopping</a>
          </div>

          
</div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
      crossorigin="anonymous"
    ></script>

</body>
</html>