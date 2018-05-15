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
 * Servlet implementation class AuditDeal
 */
@WebServlet(description = "审核处理", urlPatterns = { "/AuditDeal" })
public class AuditDeal extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AuditDeal() {
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
		int paperid = Integer.parseInt(json.getString("paperid"));
		int auditorid = (int) request.getSession().getAttribute("id");
		String time = json.getString("time");
		String auditflag = json.getString("auditflag");
		String views = json.getString("views"); // 审核意见
		String sql;
		PreparedStatement ps;

		sql = "insert into audit(paperid,auditorid,status,time,views) value(?,?,?,?,?)";
		ps = db.getPs(sql);
		try {
			ps.setInt(1, paperid);
			ps.setInt(2, auditorid);
			ps.setString(3, auditflag);
			ps.setString(4, time);
			ps.setString(5, views);
			int row = ps.executeUpdate();
			if (row > 0) {

				sql = "update paper set auditflag = ? where id = ?";
				ps = db.getPs(sql);
				try {
					ps.setString(1, auditflag);
					ps.setInt(2, paperid);
					row = ps.executeUpdate();
					if (row > 0) {
						out.print("1"); // 1代表成功
					} else {
						out.print("2"); // 2代表失败
					}
					ps.close();
					db.getConnect().close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			} else {
				out.print("2"); // 2代表失败
				ps.close();
				db.getConnect().close();
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		out.flush();
		out.close();

	}

}
