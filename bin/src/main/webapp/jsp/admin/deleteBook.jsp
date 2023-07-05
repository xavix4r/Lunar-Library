<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
try {
    Class.forName("com.mysql.jdbc.Driver");
    String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
    Connection conn = DriverManager.getConnection(connURL);

    int bookId = Integer.parseInt(request.getParameter("bookId"));
    String sqlStr = "DELETE FROM books WHERE book_id = ?";
    PreparedStatement stmt = conn.prepareStatement(sqlStr);
    stmt.setInt(1, bookId);
    int rowsDeleted = stmt.executeUpdate();

    stmt.close();
    conn.close();

    if (rowsDeleted > 0) {
        request.setAttribute("deleteResult", "Book ID " + bookId + " has been successfully deleted");
    } else {
        request.setAttribute("deleteResult", "Failed to delete Book ID " + bookId);
    }
} catch (Exception e) {
    e.printStackTrace();
}
%>
<jsp:forward page="manageBook.jsp" />
