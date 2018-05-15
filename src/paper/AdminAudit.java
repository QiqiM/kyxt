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
 * Servlet implementation class AdminAudit
 */
@WebServlet(description = "管理员审核论文", urlPatterns = { "/AdminAudit" })
public class AdminAudit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminAudit() {
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
				deleteSingle(request, response);
				break;
			default:
				queryList(request, response);
			}

		} else {
			queryList(request, response);
		}
	}

	private void deleteSingle(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

	}

	private void queryList(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		PrintWriter out = response.getWriter();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		String json = "";
		int numbers = 0;
		Db db = new Db();
		int tid = (int) request.getSession().getAttribute("id");
		String title = request.getParameter("title");
		String pubtime = request.getParameter("pubtime");
		String firstauthor = request.getParameter("firstauthor");
		String subtypeid = request.getParameter("subtypeid");
		String majorname = request.getParameter("majorname");
		String teacherid = request.getParameter("teacherid");
		String auditflag = request.getParameter("auditflag");

		int limit = Integer.parseInt(request.getParameter("limit"));
		int page = Integer.parseInt(request.getParameter("page"));
		int offset = limit * (page - 1);
		String sql = ""; // 查询总数据的最终sql拼接语句
		String sqlf = "select * from TeacherQueryPaper where 1=1  "; // sql头部
		// 分页查询
		String sqle = " limit " + offset + "," + limit + ""; // sql尾部
		String sql1 = "select count(*) numbers from TeacherQueryPaper where 1=1  "; // 得到count值，总结果值
		String str = "";
		if (title == "" || title == null) {

		} else {
			str = str + " and title like '%" + title + "%'";
		}

		if (firstauthor == "" || firstauthor == null) {

		} else {
			str = str + " and firstauthor like '%" + firstauthor + "%'";
		}

		if (subtypeid == "" || subtypeid == null) {

		} else {
			str = str + " and subtypeid like '%" + subtypeid + "%'";
		}

		if (auditflag == "" || auditflag == null) {

		} else {
			str = str + " and auditflag like '%" + auditflag + "%'";
		}

		if (pubtime == "" || pubtime == null) {

		} else {
			String[] aa;
			aa = pubtime.split(" - ");
			// System.out.println(aa[0] + aa[1]);
			str = str + " and (pubtime > '" + aa[0] + "' and pubtime < '" + aa[1] + " ')";
		}
		if (majorname == "" || majorname == null) {

		} else {
			str = str + " and majorname like '%" + majorname + "%'";
		}
		if (teacherid == "" || teacherid == null) {

		} else {
			str = str + " and teacherid like '%" + teacherid + "%'";
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

		List<QueryPaper> paperList = new ArrayList<QueryPaper>();
		QPJson qpJson = new QPJson();
		qpJson.setCode(0);
		qpJson.setCount(numbers);
		qpJson.setMsg("");

		try {
			ResultSet rs;
			PreparedStatement ps;
			ps = db.getPs(sql);
			ps = db.getPs(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				QueryPaper paper = new QueryPaper();
				paper.setPaperid(rs.getInt(1));
				paper.setTitle(rs.getString(2));
				paper.setFirstauthor(rs.getString(3));
				paper.setPubtime(rs.getDate(4));
				paper.setPubarea(rs.getString(5));
				paper.setIstrans(rs.getString(6));

				paper.setAuditflag(rs.getString(7));
				paper.setSourcename(rs.getString(8));
				paper.setPubpartname(rs.getString(9));
				paper.setSubpartname(rs.getString(10));
				paper.setJournalname(rs.getString(11));
				paper.setFirstsubname(rs.getString(12));
				paper.setTeacherid(rs.getInt(13));
				paper.setProsourceid(rs.getInt(14));
				paper.setFirstsubid(rs.getInt(15));
				paper.setSubtypeid(rs.getInt(16));
				paper.setJournalid(rs.getInt(17));
				paper.setPubtypeid(rs.getInt(18));
				paper.setMajorname(rs.getString(19));
				paper.setMentorflag(rs.getString(20));
				paper.setLayout(rs.getString(21));
				paper.setFileurl(rs.getString(22));

				paperList.add(paper);
			}
			qpJson.setData(paperList);
			json = gson.toJson(qpJson);
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
