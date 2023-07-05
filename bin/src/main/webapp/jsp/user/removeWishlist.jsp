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

	String sqlStr = "DELETE from wishlist WHERE user_id = ? and book_id = ?";
	PreparedStatement deleteStmt = conn.prepareStatement(sqlStr);
	deleteStmt.setInt(1, userId);
	deleteStmt.setInt(2, bookID);

	int count = deleteStmt.executeUpdate();

	deleteStmt.close();
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