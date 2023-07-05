<%@ page import="java.sql.*" %>
<%
String username = (String) session.getAttribute("sessUsername");
String oldpw = request.getParameter("oldpw");
String newpw = request.getParameter("newpw");
String newpwconfirm = request.getParameter("newpwconfirm");

if (!newpw.equals(newpwconfirm)) {
    response.getWriter().write("newPwNoMatch");
}

try {
    Class.forName("com.mysql.jdbc.Driver");
    String connURL = "jdbc:mysql://localhost/lunar_db?user=root&password=123456&serverTimezone=UTC";
    Connection conn = DriverManager.getConnection(connURL);

    String sqlStr = "SELECT password FROM users WHERE username = ?";
    PreparedStatement stmt = conn.prepareStatement(sqlStr);
    stmt.setString(1, username);

    ResultSet rs = stmt.executeQuery();

    if (rs.next()) {
        String currentPw = rs.getString("password");

        if (!oldpw.equals(currentPw)) {
            response.getWriter().write("currentNoMatch");
        } else if (newpw.equals(newpwconfirm) && oldpw.equals(currentPw)) {
            sqlStr = "UPDATE users SET password = ? WHERE username = ?";
            stmt = conn.prepareStatement(sqlStr);
            stmt.setString(1, newpw);
            stmt.setString(2, username);

            int count = stmt.executeUpdate();

            response.getWriter().write("success");
        }

    } else {
        response.getWriter().write("error");
    }

    stmt.close();
    conn.close();
} catch (Exception e) {
    out.println("Error: " + e);
}
%>
