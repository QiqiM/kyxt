package paper;

import java.sql.Date;

//添加论文使用的bean
public class PaperBean {
	private String title;
	private String firstauthor;
	private Date pubtime;
	private int pubtypeid;
	private int journalid;
	private int subtypeid;
	private int firstsubid;
	private int prosourceid;
	private String istrans;
	private String fileurl;
	private String layout;

	public int getSubtypeid() {
		return subtypeid;
	}

	public void setSubtypeid(int subtypeid) {
		this.subtypeid = subtypeid;
	}

	private String pubarea;

	public PaperBean() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getFirstauthor() {
		return firstauthor;
	}

	public void setFirstauthor(String firstauthor) {
		this.firstauthor = firstauthor;
	}

	public Date getPubtime() {
		return pubtime;
	}

	public void setPubtime(Date pubtime) {
		this.pubtime = pubtime;
	}

	public int getPubtypeid() {
		return pubtypeid;
	}

	public void setPubtypeid(int pubtypeid) {
		this.pubtypeid = pubtypeid;
	}

	public int getJournalid() {
		return journalid;
	}

	public void setJournalid(int journalid) {
		this.journalid = journalid;
	}

	public int getFirstsubid() {
		return firstsubid;
	}

	public void setFirstsubid(int firstsubid) {
		this.firstsubid = firstsubid;
	}

	public int getProsourceid() {
		return prosourceid;
	}

	public void setProsourceid(int prosourceid) {
		this.prosourceid = prosourceid;
	}

	public String getPubarea() {
		return pubarea;
	}

	public void setPubarea(String pubarea) {
		this.pubarea = pubarea;
	}

	public String getIstrans() {
		return istrans;
	}

	public void setIstrans(String istrans) {
		this.istrans = istrans;
	}

	public String getFileurl() {
		return fileurl;
	}

	public void setFileurl(String fileurl) {
		this.fileurl = fileurl;
	}

	public String getLayout() {
		return layout;
	}

	public void setLayout(String layout) {
		this.layout = layout;
	}

}
