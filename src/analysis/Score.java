package analysis;

//统计每位老师得分
public class Score {

	private int teacherid;
	private String name;
	private String majorname;
	private int pubtime;
	private int topnum;
	private int topgrade;
	private int onenum;
	private int onegrade;
	private int twonum;
	private int twograde;
	private int lastgrade;

	public int getTeacherid() {
		return teacherid;
	}

	public void setTeacherid(int teacherid) {
		this.teacherid = teacherid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMajorname() {
		return majorname;
	}

	public void setMajorname(String majorname) {
		this.majorname = majorname;
	}

	public int getPubtime() {
		return pubtime;
	}

	public void setPubtime(int pubtime) {
		this.pubtime = pubtime;
	}

	public int getTopnum() {
		return topnum;
	}

	public void setTopnum(int topnum) {
		this.topnum = topnum;
	}

	public int getTopgrade() {
		return topgrade;
	}

	public void setTopgrade(int topgrade) {
		this.topgrade = topgrade;
	}

	public int getOnenum() {
		return onenum;
	}

	public void setOnenum(int onenum) {
		this.onenum = onenum;
	}

	public int getOnegrade() {
		return onegrade;
	}

	public void setOnegrade(int onegrade) {
		this.onegrade = onegrade;
	}

	public int getTwonum() {
		return twonum;
	}

	public void setTwonum(int twonum) {
		this.twonum = twonum;
	}

	public int getTwograde() {
		return twograde;
	}

	public void setTwograde(int twograde) {
		this.twograde = twograde;
	}

	public int getLastgrade() {
		return lastgrade;
	}

	public void setLastgrade(int lastgrade) {
		this.lastgrade = lastgrade;
	}

	public Score() {
		super();
		// TODO Auto-generated constructor stub
	}

}
