package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import beans.Teacher;
import db.Db;
import db.GetReader;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class addTeacher
 */
@WebServlet(description = "add teacher", urlPatterns = { "/AddTeacher" })
public class AddTeacher extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddTeacher() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		PrintWriter out = response.getWriter();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		Teacher teacher = new Teacher();
		JSONObject json = GetReader.receivePost(request);
		teacher = gson.fromJson(json.toString(), Teacher.class);

		String res = "";
		Db db = new Db();
		PreparedStatement ps = null;
		String sql = "";
		sql = "select * from teacher where empNum = ? ";
		ps = db.getPs(sql);
		try {
			ps.setInt(1, teacher.getEmpnum());
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				res = "404";
			} else {
				sql = "insert into teacher values(?,?,?,?,?,?,?,?) ";
				ps = db.getPs(sql);
				try {
					ps.setInt(1, teacher.getEmpnum());
					ps.setString(2, teacher.getName());
					ps.setString(3, teacher.getPassword());
					ps.setString(4, teacher.getSex());
					ps.setInt(5, teacher.getMajorid());
					ps.setInt(6, teacher.getTitleid());
					ps.setString(7, teacher.getTelephone());
					ps.setDate(8, teacher.getBirthday());
					int row = ps.executeUpdate();
					if (row > 0) {
						res = "1";
					} else {
						res = "2";
					}

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
			out.print(res);
			out.flush();
			out.close();
			// rs.close();
			// ps.close();
			// db.getConnect().close();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

	}

}
