package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.Db;
import net.sf.json.JSONArray;

/**
 * Servlet implementation class TeacherShow
 */
@WebServlet(description = "教师查看论文的审核情况", urlPatterns = { "/TeacherShow" })
public class TeacherShow extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TeacherShow() {
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
		PrintWriter out = response.getWriter();
		int tid = (int) request.getSession().getAttribute("id"); // 从session中获取教师的职工号
		Db db = new Db();
		ResultSet rs;
		PreparedStatement ps;
		// int num1 = 0;
		ArrayList<Integer> list = new ArrayList<Integer>();

		int[] num = new int[10];
		String sql = "select count(*) numbers from paper where teacherid = ? ";
		String[] str = { "审核通过", "未通过", "未审核" };
		ps = db.getPs(sql);
		try {
			ps.setInt(1, tid);
			rs = ps.executeQuery();
			if (rs.next()) {
				list.add(rs.getInt("numbers"));
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

		for (int i = 0; i < str.length; i++) {
			sql = "select count(*) numbers from paper where teacherid = ? and auditflag = ? ";
			ps = db.getPs(sql);
			try {
				ps.setInt(1, tid);
				ps.setString(2, str[i]);
				rs = ps.executeQuery();
				if (rs.next()) {
					list.add(rs.getInt("numbers"));
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

		}
		JSONArray arry = JSONArray.fromObject(list);

		out.print(arry);
		out.flush();
		out.close();

	}

}
