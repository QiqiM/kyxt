package paper;

import java.sql.Timestamp;

//审核记录查询使用的bean
public class AuditBean {
	private Timestamp time;
	private int auditorid;
	private String auditor;
	private String status;
	private String views;

	public Timestamp getTime() {
		return time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public int getAuditorid() {
		return auditorid;
	}

	public void setAuditorid(int auditorid) {
		this.auditorid = auditorid;
	}

	public String getAuditor() {
		return auditor;
	}

	public void setAuditor(String auditor) {
		this.auditor = auditor;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getViews() {
		return views;
	}

	public void setViews(String views) {
		this.views = views;
	}

	public AuditBean() {
		super();
		// TODO Auto-generated constructor stub
	}

}
