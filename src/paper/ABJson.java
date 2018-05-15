package paper;

import java.util.List;

//审核记录传递到前端的Json数据
public class ABJson {
	private int code;
	private String msg;
	private int count;
	private List<AuditBean> data;

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

	public List<AuditBean> getData() {
		return data;
	}

	public void setData(List<AuditBean> data) {
		this.data = data;
	}

	public ABJson() {
		super();
		// TODO Auto-generated constructor stub
	}

}
