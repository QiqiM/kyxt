package paper;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DownLoadFile
 */
@WebServlet(description = "下载文件", urlPatterns = { "/DownLoadFile" })
public class DownLoadFile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DownLoadFile() {
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
		// 文件的路径"G:\\MyJava\\yttweb\\WebRoot\\WEB-INF\\uploadFile"
		// response.setContentType("application/json");
		response.setContentType("text/html");
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		String savepath = "G:/MyJava/yttweb/WebRoot/WEB-INF/uploadFile/";
		String fileurl = request.getParameter("filename");
		// System.out.println(fileurl);
		String filename = savepath + fileurl;

		// 获得请求文件名

		// System.out.println(filename);

		// 设置文件MIME类型
		response.setContentType(getServletContext().getMimeType(filename));
		// 设置Content-Disposition
		response.setHeader("Content-Disposition", "attachment;filename=" + filename);
		// 读取目标文件，通过response将目标文件写到客户端
		// 获取目标文件的绝对路径

		// System.out.println(fullFileName);
		// 读取文件
		InputStream in = new FileInputStream(filename);
		OutputStream out = response.getOutputStream();

		// 写文件
		int b;
		while ((b = in.read()) != -1) {
			out.write(b);
		}

		in.close();
		out.close();
	}

}
