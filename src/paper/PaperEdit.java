package paper;

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
 * Servlet implementation class PaperEdit
 */
@WebServlet(description = "教师修改论文", urlPatterns = { "/PaperEdit" })
public class PaperEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PaperEdit() {
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
		int paperid = Integer.parseInt(json.getString("id"));
		String title = json.getString("title");
		String firstauthor = json.getString("firstauthor");
		String pubtime = json.getString("time");
		int subpartid = json.getInt("subtypeid");
		int firstsubid = json.getInt("firstsubid");
		int pubpartid = json.getInt("pubtypeid");
		int journalid = json.getInt("journalid");
		int prosourceid = json.getInt("prosourceid");
		String layout = json.getString("layout");
		String pubarea = json.getString("pubarea");
		String istrans = json.getString("istrans");
		String auditflag = "未审核";
		String sql;
		PreparedStatement ps;
		sql = "update paper set title = ?,firstauthor = ?,pubtime = ?,subtypeid = ?, firstsubid = ?,pubtypeid = ?,journalid = ? ,prosourceid= ?,layout= ?,pubarea = ?,istrans= ? ,auditflag = ? where id = ?";
		ps = db.getPs(sql);
		try {
			ps.setString(1, title);
			ps.setString(2, firstauthor);
			ps.setString(3, pubtime);
			ps.setInt(4, subpartid);
			ps.setInt(5, firstsubid);
			ps.setInt(6, pubpartid);
			ps.setInt(7, journalid);
			ps.setInt(8, prosourceid);
			ps.setString(9, layout);
			ps.setString(10, pubarea);
			ps.setString(11, istrans);
			ps.setString(12, auditflag);
			ps.setInt(13, paperid);

			int row = ps.executeUpdate();
			if (row > 0) {
				out.print("1"); // 1代表编辑修改成功
			} else {
				out.print("2"); // 2代表编辑修改失败
			}
			ps.close();
			db.getConnect().close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.flush();
		out.close();

	}

}
