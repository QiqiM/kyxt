package selects;

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

import beans.Item;
import beans.ItemSelJson;
import db.Db;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class FirstSub
 */
@WebServlet(description = "动态加载一级学科", urlPatterns = { "/FirstSub" })
public class FirstSub extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FirstSub() {
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
			case "load":
				Load(request, response);
				break;
			case "findvalue":
				FindValue(request, response);
				break;
			default:
				Load(request, response);
			}

		} else {
			Load(request, response);
		}
	}

	private void FindValue(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		Db db = new Db();
		int id = 0;
		String name = request.getParameter("firstsubname");

		String sql = "select * from projectsource where firstsubname = ?";

		PreparedStatement ps = db.getPs(sql);

		try {
			ps.setString(1, name);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				id = rs.getInt("id");
				rs.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String string1 = "{\"id\":" + id + "}";
		JSONObject json = JSONObject.fromObject(string1.toString());
		out.print(json);
		out.flush();
		out.close();
	}

	private void Load(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		int subtypeid = Integer.parseInt(request.getParameter("subtypeid"));
		String sql = "";
		List<Item> ListM = new ArrayList<Item>();
		Gson gson = new Gson();
		ItemSelJson seljson = new ItemSelJson();
		String json = "";
		Db db = new Db();
		ResultSet rs = null;
		if (subtypeid == 1) {
			sql = "select * from firstsub";
			PreparedStatement ps = db.getPs(sql);
			try {
				rs = ps.executeQuery();
				while (rs.next()) {
					Item item = new Item();
					item.setId(rs.getInt(1));
					item.setName(rs.getString(2));
					ListM.add(item);
				}
				rs.close();
				ps.close();
				db.getConnect().close();
			} catch (SQLException e) {

				e.printStackTrace();
			}

		} else {
			sql = "select * from firstsub where subpartid = ?";
			PreparedStatement ps = db.getPs(sql);
			try {
				ps.setInt(1, subtypeid);
				rs = ps.executeQuery();
				while (rs.next()) {
					Item item = new Item();
					item.setId(rs.getInt(1));
					item.setName(rs.getString(2));
					ListM.add(item);
				}
				rs.close();
				ps.close();
				db.getConnect().close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		// System.out.println(subtypeid);

		seljson.setItem(ListM);
		json = gson.toJson(seljson);
		out.print(json);
		out.flush();
		out.close();

	}

}
