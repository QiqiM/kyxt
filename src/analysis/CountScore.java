package analysis;

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
 * Servlet implementation class CountScore
 */
@WebServlet(description = "统计教师论文得分", urlPatterns = { "/CountScore" })
public class CountScore extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CountScore() {
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
		int numbers = 0;
		Db db = new Db();
		String major = request.getParameter("major");
		String pubtime = request.getParameter("pubtime");

		int limit = Integer.parseInt(request.getParameter("limit"));
		int page = Integer.parseInt(request.getParameter("page"));
		int offset = limit * (page - 1);
		String sql = ""; // 查询总数据的最终sql拼接语句
		String sqlf = "select * from countgrade where 1=1  "; // sql头部
		// 分页查询
		String sqle = " limit " + offset + "," + limit + ""; // sql尾部
		String sql1 = "select count(*) numbers from countgrade where 1=1  "; // 得到count值，总结果值
		String str = "";
		if (major == "" || major == null) {

		} else {
			str = str + " and  id = " + major;
		}

		if (pubtime == "" || pubtime == null) {

		} else {
			String[] aa;
			aa = pubtime.split(" - ");
			// System.out.println(aa[0] + aa[1]);
			if (aa[0].equals(aa[1])) {
				str = str + " and (pubtime >= '" + aa[0] + "' and pubtime <= '" + aa[1] + " ')";
			} else {
				str = str + " and (pubtime >='" + aa[0] + "' and pubtime < '" + aa[1] + " ')";
			}

		}

		sql1 = sql1 + str;
		sql = sqlf + str + sqle;

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

		List<Score> ScoreList = new ArrayList<Score>();
		ScoreJson scorejson = new ScoreJson();
		scorejson.setCode(0);
		scorejson.setCount(numbers);
		scorejson.setMsg("");
		int grade1 = 0, grade2 = 0, grade3 = 0;
		int num1 = 0, num2 = 0, num3 = 0;

		try {
			ResultSet rs;
			PreparedStatement ps;
			ps = db.getPs(sql);

			rs = ps.executeQuery();
			while (rs.next()) {
				Score score = new Score();
				score.setTeacherid(rs.getInt(1));
				score.setName(rs.getString(2));
				score.setMajorname(rs.getString(3));
				score.setPubtime(rs.getInt(4));
				score.setTopnum(rs.getInt(6));
				score.setOnenum(rs.getInt(8));
				score.setTwonum(rs.getInt(10));
				num1 = rs.getInt(6);
				num2 = rs.getInt(8);
				num3 = rs.getInt(10);

				int p1 = rs.getInt("partid1");
				int p2 = rs.getInt("partid2");
				int p3 = rs.getInt("partid3");
				String sqlp = "select grade from pubpart where id = ?";
				ResultSet rs1;
				PreparedStatement ps1;
				ps1 = db.getPs(sqlp);
				ps1.setInt(1, p1);
				rs1 = ps1.executeQuery();
				if (rs1.next()) {
					grade1 = rs1.getInt(1);
					rs1.close();
					ps1.close();
				}
				ps1 = db.getPs(sqlp);
				ps1.setInt(1, p2);
				rs1 = ps1.executeQuery();
				if (rs1.next()) {
					grade2 = rs1.getInt(1);
					rs1.close();
					ps1.close();
				}
				ps1 = db.getPs(sqlp);
				ps1.setInt(1, p3);
				rs1 = ps1.executeQuery();
				if (rs1.next()) {
					grade3 = rs1.getInt(1);
					rs1.close();
					ps1.close();
				}

				// System.out.println("a:" + grade1 + " b:" + grade2 + " c:" +
				// grade3);

				grade1 = grade1 * num1; // 计算每个等级的得分
				grade2 = grade2 * num2;
				grade3 = grade3 * num3;

				int lastgrade = grade1 + grade2 + grade3;

				// System.out.println("a:" + grade1 + " b:" + grade2 + " c:" +
				// grade3);

				score.setTopgrade(grade1);
				score.setOnegrade(grade2);
				score.setTwograde(grade3);
				score.setLastgrade(lastgrade);

				ScoreList.add(score);
			}
			scorejson.setData(ScoreList);
			json = gson.toJson(scorejson);
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

}
