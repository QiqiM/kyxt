package beans;

import java.util.List;

public class TeacherQJson {
	private int code;
	private String msg;
	private int count;
	private List<TeacherQ> data;

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

	public List<TeacherQ> getData() {
		return data;
	}

	public void setData(List<TeacherQ> data) {
		this.data = data;
	}

	public TeacherQJson() {
		super();
		// TODO Auto-generated constructor stub
	}

}
