

<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	String fname = request.getParameter("fname");
	String lname = request.getParameter("lname");
	String email = request.getParameter("email");
	String username = request.getParameter("username");
	String password = request.getParameter("pwd");
	String role = "member";
	
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
	    Connection conn = DriverManager.getConnection(connURL);

	    String sqlStr = "INSERT INTO users (username, password, email, role, fname, lname) VALUES (?, ?, ?, ?, ?, ?)";
	    PreparedStatement stmt = conn.prepareStatement(sqlStr);
	    stmt.setString(1, username);
	    stmt.setString(2, password);
	    stmt.setString(3, email);
	    stmt.setString(4, role);
	    stmt.setString(5, fname);
	    stmt.setString(6, lname);
	    
	    int count = stmt.executeUpdate();

	    if (count > 0) {
	    	session.setAttribute("sessUsername", username);
	    	 session.setAttribute("sessRole", role);
	    	
	    	response.sendRedirect("home.jsp");
	    } else {
	        response.sendRedirect("signUp.jsp?isValidRegister=invalid");
	    }

	    conn.close();
	} catch (Exception e) {
		response.sendRedirect("signUp.jsp?isValidRegister=invalid");
	}

	%>


</body>
</html>