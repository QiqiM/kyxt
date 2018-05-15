package paper;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import db.Db;

/**
 * Servlet implementation class AuditQuery
 */
@WebServlet(description = "查询审核详情的处理", urlPatterns = { "/AuditQuery" })
public class AuditQuery extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AuditQuery() {
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
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		PrintWriter out = response.getWriter();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = "";
		int numbers = 0;
		Db db = new Db();
		String id = request.getParameter("id");
		// System.out.println(id);
		String sql = "select * from auditquery where paperid = ? ";
		List<AuditBean> AuditList = new ArrayList<AuditBean>();
		ABJson AbJson = new ABJson();
		AbJson.setCode(0);
		AbJson.setCount(numbers);
		AbJson.setMsg("");

		try {
			ResultSet rs;
			PreparedStatement ps;
			ps = db.getPs(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			while (rs.next()) {
				AuditBean auditBean = new AuditBean();
				auditBean.setTime(rs.getTimestamp(3));
				auditBean.setAuditor(rs.getString(5));
				auditBean.setAuditorid(rs.getInt(1));
				auditBean.setStatus(rs.getString(2));
				auditBean.setViews(rs.getString(4));

				AuditList.add(auditBean);
			}
			AbJson.setData(AuditList);
			json = gson.toJson(AbJson);
			// System.out.println(json);
			rs.close();
			ps.close();
			db.getConnect().close();
			out.print(json);
		} catch (SQLException e) {

			e.printStackTrace();
		}

	}

}
