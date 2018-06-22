package test;

public class SplitString {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String a = "a/b/c/";
		String[] tempStrings;
		tempStrings = a.split("/");
		for (int i = 0; i < tempStrings.length; i++) {
			System.out.println(tempStrings[i] + "aa");
		}

	}

}
