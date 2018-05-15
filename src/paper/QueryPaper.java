package paper;

import java.sql.Date;

//查询论文用的bean  20项
public class QueryPaper {
	public QueryPaper() {
		super();
		// TODO Auto-generated constructor stub
	}

	private int paperid;
	private String title;
	private String firstauthor;
	private Date pubtime;
	private String pubarea;
	private String istrans;
	private String layout;
	private String auditflag;
	private String sourcename;
	private int prosourceid;
	private String pubpartname;
	private int teacherid;
	private String fileurl;

	public String getFileurl() {
		return fileurl;
	}

	public void setFileurl(String fileurl) {
		this.fileurl = fileurl;
	}

	public int getTeacherid() {
		return teacherid;
	}

	public void setTeacherid(int teacherid) {
		this.teacherid = teacherid;
	}

	public int getPaperid() {
		return paperid;
	}

	public void setPaperid(int paperid) {
		this.paperid = paperid;
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

	public String getLayout() {
		return layout;
	}

	public void setLayout(String layout) {
		this.layout = layout;
	}

	public String getAuditflag() {
		return auditflag;
	}

	public void setAuditflag(String auditflag) {
		this.auditflag = auditflag;
	}

	public String getSourcename() {
		return sourcename;
	}

	public void setSourcename(String sourcename) {
		this.sourcename = sourcename;
	}

	public int getProsourceid() {
		return prosourceid;
	}

	public void setProsourceid(int prosourceid) {
		this.prosourceid = prosourceid;
	}

	public String getPubpartname() {
		return pubpartname;
	}

	public void setPubpartname(String pubpartname) {
		this.pubpartname = pubpartname;
	}

	public int getPubtypeid() {
		return pubtypeid;
	}

	public void setPubtypeid(int pubtypeid) {
		this.pubtypeid = pubtypeid;
	}

	public String getJournalname() {
		return journalname;
	}

	public void setJournalname(String journalname) {
		this.journalname = journalname;
	}

	public int getJournalid() {
		return journalid;
	}

	public void setJournalid(int journalid) {
		this.journalid = journalid;
	}

	public String getSubpartname() {
		return subpartname;
	}

	public void setSubpartname(String subpartname) {
		this.subpartname = subpartname;
	}

	public int getSubtypeid() {
		return subtypeid;
	}

	public void setSubtypeid(int subtypeid) {
		this.subtypeid = subtypeid;
	}

	public String getFirstsubname() {
		return firstsubname;
	}

	public void setFirstsubname(String firstsubname) {
		this.firstsubname = firstsubname;
	}

	public int getFirstsubid() {
		return firstsubid;
	}

	public void setFirstsubid(int firstsubid) {
		this.firstsubid = firstsubid;
	}

	public String getMajorname() {
		return majorname;
	}

	public void setMajorname(String majorname) {
		this.majorname = majorname;
	}

	public String getMentorflag() {
		return mentorflag;
	}

	public void setMentorflag(String mentorflag) {
		this.mentorflag = mentorflag;
	}

	private int pubtypeid;
	private String journalname;
	private int journalid;
	private String subpartname;
	private int subtypeid;
	private String firstsubname;
	private int firstsubid;
	private String majorname;
	private String mentorflag;

}
