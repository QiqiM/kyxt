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
import javax.servlet.http.HttpSession;

import db.Db;
import db.GetReader;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		JSONObject json = GetReader.receivePost(request);
		int username = json.getInt("username");
		String password = json.getString("password");
		String access = json.getString("access"); // 身份标志

		Db db = new Db();
		ResultSet rs;
		PreparedStatement ps;
		String sql = "";
		String resdata = "";
		HttpSession session = request.getSession();
		if (access.equals("1")) {
			sql = "select * from admin where account= ?";
			ps = db.getPs(sql); // 预处理
			try {
				ps.setInt(1, username);
				rs = ps.executeQuery();
				if (rs.next()) {
					if (password.equals(rs.getString("password"))) {
						resdata = "{\"success\": \"true\", \"msg\": \"1\"}";
						session.setAttribute("username", rs.getString("name"));
						session.setAttribute("access", access);
					} else {
						resdata = "{\"success\": \"false\", \"msg\": \"管理员密码错误\"}";
					}
				}
				// 不存在该管理员
				else {
					resdata = "{\"success\": \"false\", \"msg\": \"不存在该管理员\"}";
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} else {
			sql = "select * from teacher where empNum= ?";
			ps = db.getPs(sql);
			try {
				ps.setInt(1, username);
				rs = ps.executeQuery();
				if (rs.next()) {
					if (password.equals(rs.getString("password"))) {
						session.setAttribute("username", rs.getString("name"));
						session.setAttribute("access", access);
						resdata = "{\"success\": \"true\", \"msg\": \"2\"}";
					} else {
						resdata = "{\"success\": \"false\", \"msg\": \"教师密码错误\"}";
					}
				}
				// 不存在该教师
				else {
					resdata = "{\"success\": \"false\", \"msg\": \"不存在该教师\"}";
				}
				rs.close();
				ps.close();

			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		out.print(resdata);
		out.flush();
		out.close();

	}

}
