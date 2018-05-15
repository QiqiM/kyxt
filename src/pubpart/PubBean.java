package pubpart;

//刊物类型查询所需的bean
public class PubBean {
	private int id;
	private String name;
	private int grade;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public PubBean() {
		super();
		// TODO Auto-generated constructor stub
	}

}
