<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import ="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
String username = (String) session.getAttribute("sessUsername");
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String email = request.getParameter("email");


try {
    Class.forName("com.mysql.jdbc.Driver");
    String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
    Connection conn = DriverManager.getConnection(connURL);

    String sqlStr = "UPDATE users SET fname = ?, lname = ?, email = ? WHERE username = ?";
    PreparedStatement stmt = conn.prepareStatement(sqlStr);
    stmt.setString(1, fname);
    stmt.setString(2, lname);
    stmt.setString(3, email);
    stmt.setString(4, username);
    

    int count = stmt.executeUpdate();

   /*  if (count > 0) {
       
        out.println("Update successful");
        response.sendRedirect("profilePage.jsp");
    } else {
       
        out.println("Update failed");
        response.sendRedirect("profilePage.jsp");
    } */

    stmt.close();
    conn.close();
} catch (Exception e) {
    out.println("Error: " + e);
}



%>

</body>
</html>