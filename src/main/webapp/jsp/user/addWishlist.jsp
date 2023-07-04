<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%
int userId = (int) session.getAttribute("sessUserID");
int bookID = 0;
try {
	bookID = Integer.parseInt(request.getParameter("bookId"));
	
} catch (NumberFormatException e) {
	out.print("Error:" + e);
}
%>

<%
try {
	Class.forName("com.mysql.jdbc.Driver");
	String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
	Connection conn = DriverManager.getConnection(connURL);

	String sqlStr = "INSERT INTO wishlist (user_id, book_id) VALUES (?, ?)";
	PreparedStatement insertStmt = conn.prepareStatement(sqlStr);
	insertStmt.setInt(1, userId);
	insertStmt.setInt(2, bookID);
	
	int count = insertStmt.executeUpdate();

	
	insertStmt.close();
	conn.close();

} catch (Exception e) {
	e.printStackTrace();

}
%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>