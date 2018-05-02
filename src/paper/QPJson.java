package paper;

import java.util.List;

public class QPJson {
	private int code;
	private String msg;
	private int count;
	private List<QueryPaper> data;

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public List<QueryPaper> getData() {
		return data;
	}

	public void setData(List<QueryPaper> data) {
		this.data = data;
	}

	public QPJson() {
		super();
		// TODO Auto-generated constructor stub
	}

}
