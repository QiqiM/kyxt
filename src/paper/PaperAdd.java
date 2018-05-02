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

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import db.Db;
import db.GetReader;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class PaperAdd
 */
@WebServlet(description = "教师添加论文", urlPatterns = { "/PaperAdd" })
public class PaperAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PaperAdd() {
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
		PaperBean paper = new PaperBean();
		JSONObject json = GetReader.receivePost(request);
		paper = gson.fromJson(json.toString(), PaperBean.class);
		String teachername = request.getSession().getAttribute("username").toString(); // 从获取教师name和职工编号empnum
		int tid = (int) request.getSession().getAttribute("id");
		String mentorflag;
		String auditflag = "未审核";
		if (teachername.equals(paper.getFirstauthor())) {
			mentorflag = "否";
		} else {
			mentorflag = "是";
		}

		String res = "";
		Db db = new Db();
		PreparedStatement ps = null;
		String sql = "";
		sql = "insert into paper(title,firstauthor,pubtime,pubtypeid,journalid,subtypeid,firstsubid,prosourceid,teacherid,pubarea,istrans,layout,fileurl,mentorflag,auditflag) value(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
		ps = db.getPs(sql);
		try {
			ps.setString(1, paper.getTitle());
			ps.setString(2, paper.getFirstauthor());
			ps.setDate(3, paper.getPubtime());
			ps.setInt(4, paper.getPubtypeid());
			ps.setInt(5, paper.getJournalid());
			ps.setInt(6, paper.getSubtypeid());
			ps.setInt(7, paper.getFirstsubid());
			ps.setInt(8, paper.getProsourceid());
			ps.setInt(9, tid);
			ps.setString(10, paper.getPubarea());
			ps.setString(11, paper.getIstrans());
			ps.setString(12, paper.getLayout());
			ps.setString(13, paper.getFileurl());
			ps.setString(14, mentorflag);
			ps.setString(15, auditflag);
			int row = ps.executeUpdate();
			if (row > 0) {
				res = "1";
			} else {
				res = "2";
			}
			ps.close();
			db.getConnect().close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.print(res);
		out.flush();
		out.close();

	}

}
