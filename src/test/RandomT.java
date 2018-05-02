package test;

public class RandomT {

	public static void main(String[] args) {

		int rd;
		// String str = "abc";
		for (int i = 0; i < 10; i++) {
			rd = (int) ((Math.random() * 9 + 1) * 10000);
			String str = "abc";
			str = str + rd;
			System.out.println(str);
		}

	}

}
