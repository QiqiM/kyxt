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
 * Servlet implementation class TeacherInfo
 */
@WebServlet(description = "教师详细资料", urlPatterns = { "/TeacherInfo" })
public class TeacherInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TeacherInfo() {
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
		String sql = "select empnum,name,sex,majorname,titlename,birthday,telephone from teacher,major,title where empnum = ? and major.id = teacher.majorid and teacher.titleid = title.id";
		Db db = new Db();
		int tid = Integer.parseInt(request.getParameter("tid"));
		ResultSet rs;
		PreparedStatement ps;
		ps = db.getPs(sql);

		List<TeacherQ> teacherList = new ArrayList<TeacherQ>();
		TeacherQJson teacherJson = new TeacherQJson();
		teacherJson.setCode(0);
		teacherJson.setCount(10);
		teacherJson.setMsg("");

		try {
			ps.setInt(1, tid);
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

			rs.close();
			ps.close();
			db.getConnect().close();
			out.print(json);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		out.flush();
		out.close();

	}

}
