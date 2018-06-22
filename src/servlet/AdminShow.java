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
 * Servlet implementation class AdminShow
 */
@WebServlet(description = "管理员信息通知", urlPatterns = { "/AdminShow" })
public class AdminShow extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminShow() {
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
		ArrayList<Integer> numlist = new ArrayList<Integer>();
		ArrayList<String> nameList = new ArrayList<String>();
		ArrayList<Object> list = new ArrayList<>();

		String sql = "select majorid,majorname,count(*) numbers from adminshow where  auditflag = '未审核' GROUP BY majorId,majorName ";

		ps = db.getPs(sql);
		try {

			rs = ps.executeQuery();
			while (rs.next()) {
				numlist.add(rs.getInt("numbers"));
				nameList.add(rs.getString("majorname"));
			}

			list.add(nameList);
			list.add(numlist);
			rs.close();
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		JSONArray arry = JSONArray.fromObject(list);

		out.print(arry);
		out.flush();
		out.close();

	}

}
