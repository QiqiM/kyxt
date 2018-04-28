package projectsource;

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
 * Servlet implementation class SourceAdd
 */
@WebServlet(description = "添加项目来源", urlPatterns = { "/SourceAdd" })
public class SourceAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SourceAdd() {
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
		String sourcename = json.getString("sourcename");

		String sql;
		PreparedStatement ps;

		sql = "select * from projectsource where id = ?";
		ps = db.getPs(sql);
		try {
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				out.print(1); // 1代表专业号已存在
				rs.close();
				ps.close();
				db.getConnect().close();
			} else {
				sql = "insert into projectsource values(?,?)";
				ps = db.getPs(sql);
				ps.setInt(1, id);
				ps.setString(2, sourcename);
				int row = ps.executeUpdate();
				if (row > 0) {
					out.print(2); // 2代表添加成功
				} else {
					out.print(3); // 3代表添加失败
				}
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
