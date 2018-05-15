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
 * Servlet implementation class Paperinfo
 */
@WebServlet(description = "查看论文详细信息", urlPatterns = { "/PaperInfo" })
public class PaperInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PaperInfo() {
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
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		String json = "";
		int paperid = Integer.parseInt(request.getParameter("paperid"));
		String sql = "select * from TeacherQueryPaper where id = " + paperid;
		Db db = new Db();

		ResultSet rs;
		PreparedStatement ps;
		ps = db.getPs(sql);

		List<QueryPaper> paperList = new ArrayList<QueryPaper>();
		QPJson qpJson = new QPJson();
		qpJson.setCode(0);
		qpJson.setCount(10);
		qpJson.setMsg("");

		try {

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

		out.flush();
		out.close();

	}

}
