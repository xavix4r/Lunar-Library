package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	public static Connection getConnection() {
		String dbUrl = "jdbc:mysql://localhost/lunar_db";
		String dbUser = "root";
		String dbPassword = "123456";
		String dbClass = "com.mysql.jdbc.Driver";
		
		Connection connection = null;
		
		try {
			Class.forName(dbClass);
			
			
		}catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		try {
			connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return connection;
	}

}
