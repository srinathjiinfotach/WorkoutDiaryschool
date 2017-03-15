package jdbcdatabaser;
import java.util.Scanner;
import java.sql.*;

public class Actions {
	Connection myConn;
	Statement myStmt;
	ResultSet myRs;
	
	
	public Actions(Connection connection, Statement statement) throws SQLException {
		myConn = connection;
		myStmt = statement;
	}
	
	// Usecase 1: Printer ut de 3 beste resultatene fra spesifiserte øvelser.
	public void rekorder(Scanner scanner) throws SQLException {
		ResultSet myRs;
		
		System.out.println("Hvilken øvelse vil du se rekordene på? ");
		
		String sql = "select ØvelseID, Navn from Øvelse";
		myRs = myStmt.executeQuery(sql);
		while (myRs.next()) {
			System.out.println(myRs.getString("ØvelseID") + ": " +  myRs.getString("Navn"));
		}
		int ovelseID = Integer.parseInt(scanner.nextLine());
		System.out.println("B: Belastning\nV: Varighet");
		String s = scanner.nextLine().toUpperCase();
		String str;
		String order;
		if (s.equals("B")) {str = "Belastning"; order = "desc";}
		else {str = "Varighet"; order = "asc";}
		
		String getExercise = "select Navn from Øvelse where ØvelseID = " + ovelseID;
		myRs = myStmt.executeQuery(getExercise);
		while (myRs.next()) {
			System.out.println("\nI øvelsen '" + myRs.getString("Navn") + "' finnes disse rekordene");
		}
		String notation;
		if (str.equals("Belastning")) {notation = " kg";} else {notation = " min";}
		
		sql = "select " +  str + " as REKORDER from GjortI where GjortI.ØvelseID = " + ovelseID + " order by " + str + " " + order + " limit 3";
		myRs = myStmt.executeQuery(sql);

		while (myRs.next()) {
			System.out.println(myRs.getString("REKORDER") + notation);
		}
	}

	// Usecase 2: Printer ut div info fra øktene i tidsintervallet som velges av bruker.
	public void økt(Scanner scanner) throws SQLException {
		
		System.out.println("Hvilket datointervall vil du hente økter fra, på formen YYYYMMDD,YYYYMMDD, [X for å gå tilbake til startmenyen]");
		String str = scanner.nextLine();
		if (str.toUpperCase().equals("X")){
			System.out.println("hallo");
		}
		else {
			String s1 = str.split(",")[0];
			String s2 = str.split(",")[1];
			
			String sqlCount = "select count(*) as total from Økt where Økt.Dato >= " + s1 + " and Økt.Dato <= " + s2;
			String sqlSum = "select sum(Varighet) as total from Økt where Økt.Dato >= " + s1 + " and Økt.Dato <= " + s2;
			String sqlDistinct = "select count(distinct(ØvelseID)) as total from GjortI where GjortI.Dato >= " + s1 + " and GjortI.Dato <= " + s2;
			String sqlAvg = "select avg(Prestasjon) as total from Økt where Økt.Dato >= " + s1 + " and Økt.Dato <= " + s2;
			ResultSet myRs;
			
			myRs = myStmt.executeQuery(sqlCount);
			while (myRs.next()) {
				System.out.println("\nAntall økter: " + myRs.getString("total"));
			}
			myRs = myStmt.executeQuery(sqlSum);
			while (myRs.next()) {
				System.out.println("Treningstid i min: " + myRs.getString("total"));
			}
			myRs = myStmt.executeQuery(sqlDistinct);
			while (myRs.next()) {
				System.out.println("Antall forskjellige øvelser: " + myRs.getString("total"));
			}				
			myRs = myStmt.executeQuery(sqlAvg);
			while (myRs.next()) {
				System.out.println("Gjennomsnittlig prestasjon: " + myRs.getString("total"));
			}
		}
	}
	
	// Usecase 3: Registrer økt.
	public void registrerØkt(Scanner scanner) throws SQLException {
		// 1. Be brukeren oppgi verdier for dato og varighet.  Vær, temp, tilskuere, form, prestasjon og notat er valgfritt.  Trykker enter for å la disse stå blankt.
		System.out.print("Oppgi dato (format: YYYYMMDD): ");
		String dato = scanner.nextLine();
		System.out.print("Oppgi varighet i minutter: ");
		int varighet = Integer.parseInt(scanner.nextLine());
		System.out.println("Oppgi temperatur: ");
		int temp = Integer.parseInt(scanner.nextLine());
		
		String sql = "Insert into Økt (Dato, Varighet, Temperatur) values (" + dato + ", " + varighet + ", " + temp + ")";
		myStmt.executeUpdate(sql);
		// 2. Spørre brukeren om han vil legge til øvelse som er gjennomført i økten.
		
		while (true) {
			System.out.println("Ønsker du å legge til en øvelse som er gjennomført i økten? (y/n): ");
			String ans = scanner.nextLine();
			if (ans.toLowerCase().equals("n")) break;
			else {
				sql = "select ØvelseID, Navn from Øvelse";
				ResultSet myRs = myStmt.executeQuery(sql);
				while (myRs.next()) {
					System.out.println(myRs.getString("ØvelseID") + ": " +  myRs.getString("Navn"));
				}
				System.out.println("\nVelg nummer på øvelse som ønskes lagt til");
				int ovelseID = Integer.parseInt(scanner.nextLine());
				
				
				System.out.println("Oppgi belastning: ");
				int belastning = Integer.parseInt(scanner.nextLine());
				System.out.println("Oppgi sett: ");
				int sett = Integer.parseInt(scanner.nextLine());
				System.out.println("Oppgi repetisjoner: ");
				int reps = Integer.parseInt(scanner.nextLine());
				System.out.println("Oppgi lengde: ");
				int lengde = Integer.parseInt(scanner.nextLine());
				System.out.println("Oppgi varighet: ");
				int ovelseVarighet = Integer.parseInt(scanner.nextLine());
				
				
				sql = "INSERT INTO GjortI Values (" + dato + ", " + ovelseID +
						", " + belastning + ", " + sett + ", " + reps + 
						", " + lengde + ", " + ovelseVarighet + ")";
				myStmt.executeUpdate(sql);
			}			
		}
	}
	
	// Usecase 4: Legger inn nye øvelser
	public void registrerØvelse(Scanner scanner) throws SQLException {
		
		while (true) {
			System.out.print("Navn på øvelse: ");
			String name = scanner.nextLine();
			System.out.print("Beskrivelse: ");
			String description = scanner.nextLine();
			
			String sql = "insert into Øvelse (Navn, Beskrivelse) values " + "('" + name + "', '" + description + "')";
			myStmt.executeUpdate(sql);
			System.out.println("Øvelse '" + name + "' er nå registrert i databasen!");
			
			System.out.println("Ønsker du å legge inn en ny øvelse? [y/n]");
			String answ = scanner.nextLine();
			if (answ.toUpperCase().equals("N")) { break;}
			else {continue;}
		
		}
	
	}
	
	// Usecase 5: Legg inn mål for øvelser
	public void registrerMål(Scanner scanner) throws SQLException {
		
		while (true) {
			String sql = "select ØvelseID, Navn from Øvelse";
			ResultSet myRs = myStmt.executeQuery(sql);
			while (myRs.next()) {
				System.out.println(myRs.getString("ØvelseID") + ": " +  myRs.getString("Navn"));
			}
			System.out.print("\nVelg spesifisert øvelse ");
			int ovelseID = Integer.parseInt(scanner.nextLine());
			
			System.out.println("\nEr dette en:\nS: Styrkeøvelse\nK: Kondisjonsøvelse");
			String exercise = scanner.nextLine();
			
			String ovelse = "";
			sql = "select Navn from Øvelse where ØvelseID = " + ovelseID;
			myRs = myStmt.executeQuery(sql);
			while (myRs.next()) {
				ovelse = myRs.getString("Navn");
			}
			
			System.out.println("Du har valgt å sette mål for '" + ovelse + "'");
			if (exercise.toUpperCase().equals("S")) {// Styrke
				System.out.print("Oppgi belastning: ");
				String belastning = scanner.nextLine();
				System.out.print("Oppgi antall sett: ");
				String sett = scanner.nextLine();
				System.out.print("Oppgi antall repetisjoner: ");
				String reps = scanner.nextLine();
				System.out.println("Oppgi dagens dato på formen YYYYMMDD");
				String dato = scanner.nextLine();
				
				sql = "insert into Mål (ØvelseID, DatoSatt, Belastning, Sett, Repetisjoner, Nådd) values "
						+ "(" + ovelseID + ", " + dato + ", " + belastning + ", " + sett + ", "	+ reps + ", " + "0)";
				
				myStmt.executeUpdate("Update Mål set Nådd = 1 where ØvelseID = " + ovelseID); // Setter de andre målene lik 1.
				myStmt.executeUpdate(sql);
			}
			else {// Kondisjon
				System.out.print("Oppgi varighet: ");
				String varighet = scanner.nextLine();
				System.out.println("Oppgi dagens dato på formen YYYYMMDD");
				String dato = scanner.nextLine();
				
				sql = "insert into Mål (ØvelseID, DatoSatt, Varighet, Nådd) values" + 
							"(" + ovelseID + ", " + dato + ", " + varighet + ", 0)";
				
				myStmt.executeUpdate("Update Mål set Nådd = 1 where ØvelseID = " + ovelseID); // Setter de andre målene lik null.
				myStmt.executeUpdate(sql);
			}
			
			System.out.println("Ønsker du å legge til mål for en ny øvelse? [y/n]");
			String ans = scanner.nextLine();
			if (ans.toUpperCase().equals("N")) { break;}
		}
		
	}
}
