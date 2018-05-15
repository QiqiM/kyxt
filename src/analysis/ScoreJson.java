package analysis;

import java.util.List;

public class ScoreJson {
	private int code;
	private String msg;
	private int count;
	private List<Score> data;

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

	public List<Score> getData() {
		return data;
	}

	public void setData(List<Score> data) {
		this.data = data;
	}

	public ScoreJson() {
		super();
		// TODO Auto-generated constructor stub
	}

}
