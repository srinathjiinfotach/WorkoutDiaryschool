package jdbcdatabaser;
import java.sql.*;
import java.util.Scanner;

public class Driver {
	

	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		try {
			// 1.Get a connection to database
			Connection myConn =  DriverManager.getConnection("jdbc:mysql://mysql.stud.ntnu.no/fredhe_prosjekt", "akselbe", ""); // Endre her!
			Statement myStmt = myConn.createStatement();
			Actions action = new Actions(myConn, myStmt);	
			
			
	
			while (true) {
				System.out.println("\n1. Rekorder\t"
								 + "2. Informasjon om tidligere økter\t"
								 + "3. Registrer økt\t"
								 + "4. Registrer øvelse\t"
								 + "5. Regisrer mål\t"
								 + "6. Avslutt");
				int ans = Integer.parseInt(scanner.nextLine());
				
				if (ans == 1) {
					action.rekorder(scanner);
				}
				else if (ans == 2) {
					action.økt(scanner);
				}
				else if (ans == 3) {
					action.registrerØkt(scanner);
				}
				else if (ans == 4) {
					action.registrerØvelse(scanner);
				}
				else if (ans == 5) {
					action.registrerMål(scanner);
				}
				else {
					break;	
				}	
			}
			scanner.close();
		}
		catch (Exception exc) {
			System.out.println("Stek.");
			exc.printStackTrace();
		}
	}
}
