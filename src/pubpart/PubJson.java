package pubpart;

import java.util.List;

public class PubJson {
	private int code;
	private String msg;
	private int count;
	private List<PubBean> data;

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

	public List<PubBean> getData() {
		return data;
	}

	public void setData(List<PubBean> data) {
		this.data = data;
	}

	public PubJson() {
		super();
		// TODO Auto-generated constructor stub
	}

}
