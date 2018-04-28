package beans;

import java.util.List;

//维护专业，职称，学科分类，项目来源构造json使用
public class ItemJson {
	private int code;
	private String msg;
	private int count;
	private List<Item> data;

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

	public List<Item> getData() {
		return data;
	}

	public void setData(List<Item> data) {
		this.data = data;
	}

	public ItemJson() {
		super();
		// TODO Auto-generated constructor stub
	}

}
