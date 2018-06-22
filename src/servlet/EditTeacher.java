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
 * Servlet implementation class EditTeacher
 */
@WebServlet("/EditTeacher")
public class EditTeacher extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditTeacher() {
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
		JSONObject json = GetReader.receivePost(request);
		int id = Integer.parseInt(json.getString("id"));
		int empnum = Integer.parseInt(json.getString("empnum"));
		// System.out.println("empnum:" + empnum);
		String name = json.getString("name");
		String sex = json.getString("sex");
		String telephone = json.getString("telephone");
		String birthday = json.getString("birthday");
		int majorid = Integer.parseInt(json.getString("majorid"));
		int titleid = Integer.parseInt(json.getString("titleid"));
		String sql;
		PreparedStatement ps;
		if (id != empnum) {
			sql = "select * from teacher where empnum = ?";
			ps = db.getPs(sql);
			try {
				ps.setInt(1, empnum);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					out.print("1"); // 1 代表教师工号重复
					rs.close();
				} else {
					rs.close();
					sql = "update teacher set empnum = ?,name = ?,sex = ?,telephone = ?, birthday = ?,majorid = ?,titleid = ? where empnum = ?";
					ps = db.getPs(sql);
					try {
						ps.setInt(1, empnum);
						ps.setString(2, name);
						ps.setString(3, sex);
						ps.setString(4, telephone);
						ps.setString(5, birthday);
						ps.setInt(6, majorid);
						ps.setInt(7, titleid);
						ps.setInt(8, id);
						int row = ps.executeUpdate();
						ps.close();
						// db.getConnect().close();
						String sql1 = "update paper set firstauthor = ? where teacherid = ? and mentorflag = '否'";
						PreparedStatement ps1 = db.getPs(sql1);
						ps1.setString(1, name);
						ps1.setInt(2, empnum);
						int row1 = ps1.executeUpdate();
						ps1.close();
						db.getConnect().close();
						if (row > 0 && row1 > 0) {
							out.print("2"); // 2代表编辑修改成功
						} else {
							out.print("3"); // 3代表编辑修改失败
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} else {
			sql = "update teacher set empnum = ?,name = ?,sex = ?,telephone = ?, birthday = ?,majorid = ?,titleid = ? where empnum = ?";
			ps = db.getPs(sql);
			try {
				ps.setInt(1, empnum);
				ps.setString(2, name);
				ps.setString(3, sex);
				ps.setString(4, telephone);
				ps.setString(5, birthday);
				ps.setInt(6, majorid);
				ps.setInt(7, titleid);
				ps.setInt(8, empnum);
				int row = ps.executeUpdate();

				ps.close();
				// db.getConnect().close();
				String sql1 = "update paper set firstauthor = ? where teacherid = ? and mentorflag = '否'";
				PreparedStatement ps1 = db.getPs(sql1);
				ps1.setString(1, name);
				ps1.setInt(2, empnum);
				int row1 = ps1.executeUpdate();
				ps1.close();
				db.getConnect().close();
				if (row > 0 && row1 > 0) {
					out.print("2"); // 2代表编辑修改成功
				} else {
					out.print("3"); // 3代表编辑修改失败
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
