<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<%@page import="java.sql.*"%>


	<%
	String username = request.getParameter("username");
	String pwd = request.getParameter("pwd");
	
	
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
	    Connection conn = DriverManager.getConnection(connURL);

	    String sqlStr = "SELECT * FROM users WHERE username=? AND password=?";
	    PreparedStatement stmt = conn.prepareStatement(sqlStr);
	    stmt.setString(1, username);
	    stmt.setString(2, pwd);
	    ResultSet rs = stmt.executeQuery();

	    if (rs.next()) {
	        int userId = rs.getInt("user_id");
	        String retrievedUsername = rs.getString("username");
	        String role = rs.getString("role");

	        session.setAttribute("sessUserID", userId);
	        session.setAttribute("sessUsername", username);
	        session.setAttribute("sessRole", role);

	       
	        response.sendRedirect("home.jsp");
	    } else {
	        response.sendRedirect("login.jsp?isValidLogin=invalidLogin");
	    }

	    conn.close();
	} catch (Exception e) {
	    out.println("Error: " + e);
	}
%>

</body>
</html>