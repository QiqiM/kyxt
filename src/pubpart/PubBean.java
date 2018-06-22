package pubpart;

import beans.Item;

//刊物类型查询所需的bean
public class PubBean extends Item {

	private int grade;

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
