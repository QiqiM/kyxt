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
 * Servlet implementation class SubPart
 */
@WebServlet(description = "学科门类的下拉请求处理", urlPatterns = { "/SubPart" })
public class SubPart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SubPart() {
		super();

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
		String name = request.getParameter("subpartname");

		String sql = "select * from subpart where subpartname = ?";

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
		String json = "";
		Db db = new Db();

		List<Item> ListM = new ArrayList<Item>();

		Gson gson = new Gson();
		ItemSelJson seljson = new ItemSelJson();
		String sql = "";
		ResultSet rs = null;
		sql = "select * from subpart";
		PreparedStatement ps = db.getPs(sql);
		try {
			rs = ps.executeQuery();
			while (rs.next()) {
				Item item = new Item();
				item.setId(rs.getInt(1));
				item.setName(rs.getString(2));
				ListM.add(item);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		seljson.setItem(ListM);
		json = gson.toJson(seljson);
		out.print(json);
		out.flush();
		out.close();

	}

}
