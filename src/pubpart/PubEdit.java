package pubpart;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
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
 * Servlet implementation class PubEdit
 */
@WebServlet(description = "修改期刊等级对应分数", urlPatterns = { "/PubEdit" })
public class PubEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PubEdit() {
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
		int id = json.getInt("id");
		System.out.println(id);
		int grade = json.getInt("grade");

		String sql;
		PreparedStatement ps;
		sql = "update pubpart set grade = ? where id = ?";
		ps = db.getPs(sql);
		try {
			ps.setInt(1, grade);
			ps.setInt(2, id);
			int row = ps.executeUpdate();
			if (row > 0) {
				out.print("1"); // 1代表编辑修改成功
			} else {
				out.print("2"); // 2代表编辑修改失败
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.flush();
		out.close();

	}

}
