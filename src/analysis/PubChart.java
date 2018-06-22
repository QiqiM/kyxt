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
 * Servlet implementation class PubChart
 */
@WebServlet(description = "绘制专业按期刊等级发表论文数", urlPatterns = { "/PubChart" })
public class PubChart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PubChart() {
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
		// ArrayList<Integer> numlist = new ArrayList<Integer>();
		ArrayList<String> nameList = new ArrayList<String>();
		ArrayList<Object> list = new ArrayList<>();

		ArrayList<Integer> time = new ArrayList<Integer>(); // 将时间存起来
		ArrayList<Integer> timetemp = new ArrayList<Integer>();
		ArrayList<Integer> majorid = new ArrayList<Integer>(); // 将专业存起来
		ArrayList<Integer> pubid = new ArrayList<Integer>(); // 将期刊分类id存起来
		ArrayList<String> pubname = new ArrayList<String>(); // 将期刊名称存起来

		String pagetime = null;
		String pubpart = null;
		String sqlp;
		sqlp = "select DISTINCT(pubtypeid),pubpartname from pubechart ";
		pagetime = request.getParameter("pagetime");
		pubpart = request.getParameter("pubpart");
		System.out.println(pubpart);

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

		if (pubpart == "" || pubpart == null) {
			ps = db.getPs(sqlp);
			try {
				rs = ps.executeQuery();
				while (rs.next()) {
					pubid.add(rs.getInt(1));
					pubname.add(rs.getString(2));
				}
				rs.close();
				ps.close();
				list.add(pubname); // 专业名称，横坐标
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} else {
			String[] aa;
			aa = pubpart.split(",");

			for (int j = 0; j < aa.length; j++) {
				int temp = Integer.valueOf(aa[j]);
				pubid.add(temp);
			}
			String sqlp1 = "select id,pubpartname from pubpart where id = ?";
			for (int i = 0; i < pubid.size(); i++) {
				ps = db.getPs(sqlp1);
				try {
					ps.setInt(1, pubid.get(i));
					rs = ps.executeQuery();
					while (rs.next()) {
						pubname.add(rs.getString(2));
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
			list.add(pubname);

			// list.add(e);
		}

		String sql = "select majorid,majorname from majorechart where  auditflag = '审核通过'  GROUP BY majorId,majorName ";
		String sqle = "GROUP BY majorId,majorName "; // sql尾部
		ps = db.getPs(sql);
		try {
			rs = ps.executeQuery();
			while (rs.next()) {
				nameList.add(rs.getString(2)); // 获取到有哪些专业有论文发表，如果此专业一篇论文也没有，则不予以统计分析
				majorid.add(rs.getInt(1));
			}
			list.add(nameList); // legend参数
			rs.close();
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		sql = "select majorid,majorname from pubechart where  auditflag = '审核通过' and majorid = ? GROUP BY majorId,majorName ";
		for (int j = 0; j < nameList.size(); j++) {
			ps = db.getPs(sql);
			try {
				ps.setInt(1, majorid.get(j));
				rs = ps.executeQuery();
				if (rs.next()) {
					int tempm = 0;
					ArrayList<Integer> tempList1 = new ArrayList<Integer>();
					for (int h = 0; h < pubid.size(); h++) {
						String sql1 = "select majorid,majorname,count(*) numbers from pubechart where  auditflag = '审核通过' and majorid = ? ";
						String sqlb = "  and time = ?  ";
						tempm = 0;
						String sqlc = "and pubtypeid = ? ";
						sql1 = sql1 + sqlb + sqlc + sqle;

						PreparedStatement ps1;
						ps1 = db.getPs(sql1);
						ArrayList<Integer> tempList = new ArrayList<Integer>();

						for (int m = 0; m < time.size(); m++) {
							ps1.setInt(1, majorid.get(j));
							ps1.setInt(2, time.get(m));
							ps1.setInt(3, pubid.get(h));
							ResultSet rs1 = ps1.executeQuery();

							if (rs1.next()) {
								tempList.add(rs1.getInt("numbers"));
							} else {
								tempList.add(0);
							}

						}

						for (int p = 0; p < tempList.size(); p++) {
							tempm += tempList.get(p);
							// numlist.add(0);
							// System.out.println(p);
						}
						tempList1.add(tempm);

					}
					list.add(tempList1);

				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// list.add(numlist);

		}

		JSONArray arry = JSONArray.fromObject(list);

		out.print(arry);
		out.flush();
		out.close();
	}

}
