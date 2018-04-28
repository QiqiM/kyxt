package journal;

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

import beans.ItemB;
import beans.ItemBJson;
import db.Db;

/**
 * Servlet implementation class JourQuery
 */
@WebServlet(description = "发表刊物/论文集查询", urlPatterns = { "/JourQuery" })
public class JourQuery extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public JourQuery() {
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
		String methodname = request.getParameter("methodname");
		if (methodname != null) {
			switch (methodname) {

			case "deletesingle":
				deletesingle(request, response);
				break;
			default:
				queryList(request, response);
			}

		} else {
			queryList(request, response);

		}
	}

	private void queryList(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
		String json = "";
		int numbers = 0;
		Db db = new Db();
		String id = request.getParameter("id");
		String name = request.getParameter("journalname");
		// System.out.println(name);
		String partid = request.getParameter("partid");

		int limit = Integer.parseInt(request.getParameter("limit"));
		int page = Integer.parseInt(request.getParameter("page"));
		int offset = limit * (page - 1);
		String sql = ""; // 查询总数据的最终sql拼接语句
		String sqlf = "select journal.id,journalname,pubpartname from journal,pubpart where (journal.pubpartid = pubpart.id)"; // sql头部
		// 分页查询
		String sqle = "  order by journal.id limit " + offset + "," + limit + ""; // sql尾部
		String sql1 = "select count(*) numbers from journal,pubpart where (journal.pubpartid = pubpart.id)  "; // 得到count值，总结果值
		String str = "";
		if (id == "" || id == null) {

		} else {
			str = str + " and journal.id like '%" + id + "%'";
		}

		if (name == "" || name == null) {

		} else {
			str = str + " and journalname like '%" + name + "%'";
		}
		if (partid == "" || partid == null) {

		} else {
			str = str + " and pubpartid like '%" + partid + "%'";
		}

		sql1 = sql1 + str;
		sql = sqlf + str + sqle;
		// System.out.println(sql);
		try {
			ResultSet rs;
			PreparedStatement ps;
			ps = db.getPs(sql1);
			rs = ps.executeQuery();
			if (rs.next()) {
				numbers = rs.getInt("numbers");
			} else {
				out.print("<script>alert('未知错误');window.history.go(-1);</script>");
				return;
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		List<ItemB> ItembList = new ArrayList<ItemB>();
		ItemBJson ItembJson = new ItemBJson();
		ItembJson.setCode(0);
		ItembJson.setCount(numbers);
		ItembJson.setMsg("");

		try {
			ResultSet rs;
			PreparedStatement ps;
			ps = db.getPs(sql);
			ps = db.getPs(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				ItemB itemb = new ItemB();
				itemb.setId(rs.getInt(1));
				itemb.setName(rs.getString(2));
				itemb.setForname(rs.getString(3));
				ItembList.add(itemb);
			}
			ItembJson.setData(ItembList);
			json = gson.toJson(ItembJson);
			// System.out.println(json);
			rs.close();
			ps.close();
			db.getConnect().close();
			out.print(json);
			out.flush();
			out.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}

	}

	private void deletesingle(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

	}

}
