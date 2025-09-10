package com.DAO.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnector {
	private static String url = "jdbc:mysql://localhost:3306/restaurant_db";
	private static String un="root";
	private static String pwd="MyNewPassword";
	private static Connection con;
	
	public static Connection getConnection() {
	try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection(url,un,pwd);
	}
	catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}
	return con;
	}

}
