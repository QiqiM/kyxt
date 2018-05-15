package subpart;

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
 * Servlet implementation class SubPartEdit
 */
@WebServlet(description = "学科门类信息编辑", urlPatterns = { "/SubPartEdit" })
public class SubPartEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SubPartEdit() {
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
		int oldid = Integer.parseInt(json.getString("oldid"));
		int id = Integer.parseInt(json.getString("id"));
		String subpartname = json.getString("subpartname");

		String sql;
		PreparedStatement ps;
		if (id != oldid) {
			sql = "select * from subpart where id= ?";
			ps = db.getPs(sql);
			try {
				ps.setInt(1, id);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					out.print("1"); // 1 代表教师工号重复
					rs.close();
				} else {
					rs.close();
					sql = "update subpart set id = ?,subpartname = ? where id = ?";
					ps = db.getPs(sql);
					try {
						ps.setInt(1, id);
						ps.setString(2, subpartname);
						ps.setInt(3, oldid);
						int row = ps.executeUpdate();
						if (row > 0) {
							out.print(""); // 2代表编辑修改成功
						} else {
							out.print("3"); // 3代表编辑修改失败
						}
						ps.close();
						db.getConnect().close();
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
			sql = "update subpart set id = ?,subpartname = ? where id = ?";
			ps = db.getPs(sql);
			try {
				ps.setInt(1, id);
				ps.setString(2, subpartname);
				ps.setInt(3, oldid);
				int row = ps.executeUpdate();
				if (row > 0) {
					out.print("2"); // 2代表编辑修改成功
				} else {
					out.print("3"); // 3代表编辑修改失败
				}
				ps.close();
				db.getConnect().close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		out.flush();
		out.close();

	}

}
