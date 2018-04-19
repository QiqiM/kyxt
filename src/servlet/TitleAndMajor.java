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

import beans.Major;
import beans.Title;
import beans.TmSelcet;
import db.Db;

/**
 * Servlet implementation class TitleAndMajor
 */
@WebServlet("/TitleAndMajor")
public class TitleAndMajor extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TitleAndMajor() {
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
		String json = "";
		Db db = new Db();

		List<Major> ListM = new ArrayList<Major>();
		List<Title> ListT = new ArrayList<Title>();
		Gson gson = new Gson();
		TmSelcet tmSelcet = new TmSelcet();
		String sql = "";
		ResultSet rs = null;
		sql = "select * from major";
		PreparedStatement ps = db.getPs(sql);
		try {
			rs = ps.executeQuery();
			while (rs.next()) {
				Major major = new Major();
				major.setId(rs.getInt(1));
				major.setMajorName(rs.getString(2));
				ListM.add(major);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		sql = "select * from title";
		ps = db.getPs(sql);
		try {
			rs = ps.executeQuery();
			while (rs.next()) {
				Title title = new Title();
				title.setId(rs.getInt(1));
				title.setTitleName(rs.getString(2));
				ListT.add(title);
			}
			rs.close();
			ps.close();
			db.getConnect().close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		tmSelcet.setMajor(ListM);
		tmSelcet.setTitle(ListT);
		json = gson.toJson(tmSelcet);
		out.print(json);
		out.flush();
		out.close();

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
