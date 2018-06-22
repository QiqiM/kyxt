package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.Db;
import db.GetReader;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class ChangePwd
 */
@WebServlet(description = "修改密码", urlPatterns = { "/ChangePwd" })
public class ChangePwd extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChangePwd() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		Db db = new Db();

		String sql = "";
		JSONObject json = GetReader.receivePost(request);
		int account = Integer.parseInt(json.getString("account"));
		String oldpwd = json.getString("oldpwd");
		String pwd1 = json.getString("pwd1");
		String pwd2 = json.getString("pwd2");
		String access = (String) request.getSession().getAttribute("access"); // 获取session里的权限，判断是管理员登录，还是教师登录
		// System.out.println(account + oldpwd + pwd1 + pwd2); // 验证前台数据是否获取到

		if (access.equals("1")) { // 管理员修改密码

			sql = "select * from admin where account = ?";
			PreparedStatement ps;
			ps = db.getPs(sql);
			try {
				ps.setInt(1, account);
				ResultSet rs;
				rs = ps.executeQuery();
				if (rs.next()) {
					if (oldpwd.equals(rs.getString("password"))) {

						if (pwd1.equals(pwd2)) {
							sql = "update admin set password = ? where account = ?";
							ps = db.getPs(sql);
							ps.setString(1, pwd1);
							ps.setInt(2, account);
							int row = ps.executeUpdate();
							if (row > 0) {
								out.print("2"); // 2代表密码修改成功
							} else {
								out.print("3"); // 3代表密码修改失败
							}
							rs.close();
							ps.close();
							db.getConnect().close();
						} else {
							out.print("4"); // 4代表两次密码输入不一致
						}

					} else {
						out.print('1'); // 1代表旧密码不对
					}
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

		else {
			sql = "select * from teacher where empnum = ?";
			PreparedStatement ps;
			ps = db.getPs(sql);
			try {
				ps.setInt(1, account);
				ResultSet rs;
				rs = ps.executeQuery();
				if (rs.next()) {
					// System.out.println(rs.getString("password"));
					if (oldpwd.equals(rs.getString("password"))) {
						// System.out.println(123);
						if (pwd1.equals(pwd2)) {
							sql = "update teacher set password = ? where empnum = ?";
							ps = db.getPs(sql);
							ps.setString(1, pwd1);
							ps.setInt(2, account);
							int row = ps.executeUpdate();
							if (row > 0) {
								out.print("2"); // 2代表密码修改成功
							} else {
								out.print("3"); // 3代表密码修改失败
							}
							rs.close();
							ps.close();
							db.getConnect().close();
						} else {
							out.print("4"); // 4代表两次密码输入不一致
						}

					} else {
						out.print('1'); // 1代表旧密码不对
					}
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		out.flush();
		out.close();

	}

}
