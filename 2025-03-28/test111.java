package arrayMap;

public class test111 {

	public static void main(String[] args) {
		// c0001 .. c9999
		for(int i =1; i <= 9999; i++) {
			String code = "c";
//			System.out.println("c" +i);
			// 1 -> 0001, 10 -> 0010, 100->0100
			if(i >=1 && i<10) {
				code = code + "000" + i;
			}else if(i >=10 && i<100) {
				code = code + "00" + i;
			}else if(i >=100 && i<1000) {
				code = code + "0" + i;
			}else {
				code = code + i;
			}
			System.out.println(code);
			
		}

		
	}

}
