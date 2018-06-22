package analysis;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.Db;
import net.sf.json.JSONArray;

/**
 * Servlet implementation class EchartTest
 */
@WebServlet(description = "测试专业论文发表情况", urlPatterns = { "/EchartTest" })
public class EchartTest extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EchartTest() {
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
		Db db = new Db();
		ResultSet rs;
		PreparedStatement ps;
		// int num1 = 0;
		ArrayList<Integer> numlist = new ArrayList<Integer>();
		ArrayList<String> nameList = new ArrayList<String>();
		ArrayList<Object> list = new ArrayList<>();

		ArrayList<Integer> time = new ArrayList<Integer>(); // 将时间存起来
		ArrayList<Integer> timetemp = new ArrayList<Integer>();
		ArrayList<Integer> majorid = new ArrayList<Integer>();
		String pagetime = null;
		pagetime = request.getParameter("pagetime");
		// System.out.println(pagetime);
		if (pagetime == "" || pagetime == null) {
			Calendar cale = null;
			cale = Calendar.getInstance();
			int year = cale.get(Calendar.YEAR);
			year = year + 1;
			for (int i = 0; i < 5; i++) {
				year -= 1;
				timetemp.add(year);
			}

			for (int n = timetemp.size(); n > 0; n--) {
				time.add(timetemp.get(n - 1));
			}
			list.add(time);
		} else {
			String[] aa;
			aa = pagetime.split(" - ");
			int num1 = Integer.valueOf(aa[0]);
			int num2 = Integer.valueOf(aa[1]);
			int yeartemp = num2 + 1;
			int len = num2 - num1 + 1;
			for (int i = 0; i < len; i++) {
				yeartemp -= 1;
				timetemp.add(yeartemp);
			}
			for (int n = timetemp.size(); n > 0; n--) {
				time.add(timetemp.get(n - 1));
			}
			list.add(time);

		}

		String sql = "select majorid,majorname,count(*) numbers from majorechart where  auditflag = '审核通过'  GROUP BY majorId,majorName ";
		String sqle = "GROUP BY majorId,majorName "; // sql尾部
		ps = db.getPs(sql);
		try {
			rs = ps.executeQuery();
			while (rs.next()) {
				nameList.add(rs.getString(2)); // 获取到有哪些专业有论文发表，如果此专业一篇论文也没有，则不予以统计分析
				majorid.add(rs.getInt(1));
			}
			list.add(nameList);
			rs.close();
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		sql = "select majorid,majorname,count(*) numbers from majorechart where  auditflag = '审核通过' and majorid = ? GROUP BY majorId,majorName ";
		for (int j = 0; j < nameList.size(); j++) {
			ps = db.getPs(sql);
			try {
				ps.setInt(1, majorid.get(j));
				rs = ps.executeQuery();
				if (rs.next()) {
					String sql1 = "select majorid,majorname,count(*) numbers from majorechart where  auditflag = '审核通过' and majorid = ? ";
					String sqlb = "  and time = ?  ";
					sql1 = sql1 + sqlb + sqle;
					PreparedStatement ps1;
					ps1 = db.getPs(sql1);
					ArrayList<Integer> tempList = new ArrayList<Integer>();
					for (int m = 0; m < time.size(); m++) {
						ps1.setInt(1, majorid.get(j));
						ps1.setInt(2, time.get(m));
						ResultSet rs1 = ps1.executeQuery();

						if (rs1.next()) {
							tempList.add(rs1.getInt("numbers"));
						} else {
							tempList.add(0);
						}

					}
					list.add(tempList);

				}

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
