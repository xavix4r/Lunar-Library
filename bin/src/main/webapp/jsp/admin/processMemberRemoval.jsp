<%@ page import="java.sql.*" %>
<%

int id = Integer.parseInt(request.getParameter("user_id"));


try {
    Class.forName("com.mysql.jdbc.Driver");
    String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
    Connection conn = DriverManager.getConnection(connURL);

    String sqlStr = "DELETE from users WHERE user_id = ?";
    PreparedStatement deleteStmt = conn.prepareStatement(sqlStr);
    deleteStmt.setInt(1, id);

    int count = deleteStmt.executeUpdate();

    conn.close();
    System.out.print(count);

    // Return a custom response indicating the deletion status
    
} catch (Exception e) {
	System.out.print(e);
    e.printStackTrace();
}
%>
