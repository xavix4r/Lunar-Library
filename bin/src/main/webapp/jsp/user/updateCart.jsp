<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%
int userId = (int) session.getAttribute("sessUserID");
int bookID = 0;
int amountToBuy = 0;
try {
	bookID = Integer.parseInt(request.getParameter("bookId"));
	amountToBuy = Integer.parseInt(request.getParameter("amountToBuy"));
} catch (NumberFormatException e) {
	out.print("Error:" + e);
}
%>

<%
try {
	Class.forName("com.mysql.jdbc.Driver");
	String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
	Connection conn = DriverManager.getConnection(connURL);

	String updateQuery = "UPDATE cart SET quantity = ? WHERE user_id = ? AND book_id = ?";
	PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
	updateStmt.setInt(1, amountToBuy);
	updateStmt.setInt(2, userId);
	updateStmt.setInt(3, bookID);
	int count = updateStmt.executeUpdate();

	updateStmt.close();
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