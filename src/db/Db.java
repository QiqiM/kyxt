package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Db {
	private String dbDriver = "com.mysql.jdbc.Driver";
	private String ConnStr = "jdbc:mysql://localhost:3306/keyan?useUnicode=true&characterEncoding=UTF-8";
	public Connection connect = null;
	public ResultSet rs = null;

	public Connection getConnect() {
		return connect;
	}

	public void setConnect(Connection connect) {
		this.connect = connect;
	}

	public Db() {
		try {
			Class.forName(dbDriver).newInstance();
			connect = DriverManager.getConnection(ConnStr, "root", "123456");

		} catch (Exception ex) {
			System.out.println("error!");
		}
	}

	// 原生处理语句

	public ResultSet executeQuery(String sql) {
		try {
			Statement stmt = connect.createStatement();
			rs = stmt.executeQuery(sql);
		} catch (SQLException ex) {
			System.err.println(ex.getMessage());
		}
		return rs;
	}

	public void executeUpdate(String sql) {
		Statement stmt = null;
		rs = null;
		try {
			stmt = connect.createStatement();
			stmt.executeUpdate(sql);
			stmt.close();
			connect.close();

		} catch (SQLException ex) {
			System.err.println(ex.getMessage());

		}
	}

	public PreparedStatement getPs(String sql) {

		PreparedStatement ps = null; // 预处理

		try {
			ps = connect.prepareStatement(sql);

		} catch (SQLException ex) {
			System.err.println(ex.getMessage());
		}
		return ps;

	}
	// public static void main(String[] args) {
	// Db db = new Db();
	// ResultSet rs = db.executeQuery("select * from admin ");
	// try {
	// while (rs.next()) {
	// String username = rs.getString("adminname");
	// System.out.println(username);
	// }
	// } catch (SQLException e) {
	// e.printStackTrace();
	// }
	//
	// }

}
