package servlet;

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

import beans.TeacherQ;
import beans.TeacherQJson;
import db.Db;

/**
 * Servlet implementation class QyeryTeacher
 */
@WebServlet("/QueryTeacher")
public class QueryTeacher extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public QueryTeacher() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		PrintWriter out = response.getWriter();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		String json = "";
		int numbers = 0;
		Db db = new Db();
		String empnum = request.getParameter("empnum");
		String name = request.getParameter("name");
		// System.out.println(name);
		String majorname = request.getParameter("majorid");
		String titlename = request.getParameter("titleid");

		int limit = Integer.parseInt(request.getParameter("limit"));
		int page = Integer.parseInt(request.getParameter("page"));
		int offset = limit * (page - 1);
		String sql = ""; // 查询总数据的最终sql拼接语句
		String sqlf = "select empnum,name,sex,majorname,titlename,birthday,telephone from teacher,major,title where (teacher.majorid = major.id AND teacher.titleid = title.id)"; // sql头部
																																													// 分页查询
		String sqle = "order by empnum limit " + offset + "," + limit + ""; // sql尾部
		String sql1 = "select count(*) numbers from teacher,major,title where (teacher.majorid = major.id AND teacher.titleid = title.id)"; // 得到count值，总结果值
		String str = "";
		if (empnum == "" || empnum == null) {

		} else {
			str = str + "and empnum like '%" + empnum + "%'";
		}

		if (name == "" || name == null) {

		} else {
			str = str + "and name like '%" + name + "%'";
		}

		if (majorname == "" || majorname == null) {

		} else {
			str = str + "and majorid like '%" + majorname + "%'";
		}

		if (titlename == "" || titlename == null) {

		} else {
			str = str + "and titleid like '%" + titlename + "%'";
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		List<TeacherQ> teacherList = new ArrayList<TeacherQ>();
		TeacherQJson teacherJson = new TeacherQJson();
		teacherJson.setCode(0);
		teacherJson.setCount(numbers);
		teacherJson.setMsg("");

		try {
			ResultSet rs;
			PreparedStatement ps;
			ps = db.getPs(sql);
			ps = db.getPs(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				TeacherQ teacherQ = new TeacherQ();
				teacherQ.setEmpnum(rs.getInt(1));
				teacherQ.setName(rs.getString(2));
				teacherQ.setSex(rs.getString(3));
				teacherQ.setMajorname(rs.getString(4));
				teacherQ.setTitlename(rs.getString(5));
				teacherQ.setBirthday(rs.getDate(6));
				teacherQ.setTelephone(rs.getString(7));
				teacherList.add(teacherQ);
			}
			teacherJson.setData(teacherList);
			json = gson.toJson(teacherJson);
			// System.out.println(json);
			rs.close();
			ps.close();
			db.getConnect().close();
			out.print(json);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
