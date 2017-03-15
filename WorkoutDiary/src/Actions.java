import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Scanner;
import java.sql.*;
import java.util.TimeZone;

public class Actions {
    Connection myConn;
    Statement myStmt;
    ResultSet myRs;


    public Actions(Connection connection, Statement statement) throws SQLException {
        myConn = connection;
        myStmt = statement;
    }

    // Usecase 1: Printer ut de 3 beste resultatene fra spesifiserte øvelser.
    public void records(Scanner scanner) throws SQLException {
        ResultSet myRs;

        System.out.println("\nFor which exercise do you want to view the records?\n");

        String sql = "select exerciseID, name from Exercise";
        myRs = myStmt.executeQuery(sql);
        while (myRs.next()) {
            System.out.println(myRs.getString("exerciseID") + ": " +  myRs.getString("name"));
        }
        int exerciseID = Integer.parseInt(scanner.nextLine());
        System.out.println("L: Load\nD: Duration");
        String s = scanner.nextLine().toUpperCase();
        String str;
        String order;
        if (s.equals("L")) {str = "totLoad"; order = "desc";}
        else {str = "Varighet"; order = "asc";}

        String getExercise = "select name from Exercise where exerciseID = " + exerciseID;
        myRs = myStmt.executeQuery(getExercise);
        while (myRs.next()) {
            System.out.println("\nIn the exercise '" + myRs.getString("name") + "' these records exist:\n");
        }
        String notation;
        if (str.equals("performance")) {notation = " kg";} else {notation = " min";}

        sql = "select " +  str + " as REKORDER from Checklist where Checklist.exerciseID = " + exerciseID + " order by " + str + " " + order + " limit 3";
        myRs = myStmt.executeQuery(sql);

        while (myRs.next()) {
            System.out.println(myRs.getString("REKORDER") + notation);
        }
    }

    // Usecase 2: Printer ut div info fra øktene i tidsintervallet som velges av bruker.
    public void workout(Scanner scanner) throws SQLException {

        System.out.println("From which date-interval do you want to get exercises, written on the form YYYYMMDD,YYYYMMDD, " +
                "[X to go back to start]");
        String str = scanner.nextLine();
        if (str.toUpperCase().equals("X")){
            System.out.println("hallo");
        }
        else {
            String s1 = str.split(",")[0];
            String s2 = str.split(",")[1];

            String sqlCount = "select count(*) as total from Workout where Workout.date >= " + s1 + " and Workout.date <= " + s2;
            String sqlSum = "select sum(duration) as total from Workout where Workout.date >= " + s1 + " and Workout.date <= " + s2;
            String sqlDistinct = "select count(distinct(exerciseID)) as total from Checklist where Checklist.date >= " + s1 + " and Checklist.date <= " + s2;
            String sqlAvg = "select avg(performance) as total from Workout where Workout.date >= " + s1 + " and Workout.date <= " + s2;
            ResultSet myRs;

            myRs = myStmt.executeQuery(sqlCount);
            while (myRs.next()) {
                System.out.println("\nNumber of workouts: " + myRs.getString("total"));
            }
            myRs = myStmt.executeQuery(sqlSum);
            while (myRs.next()) {
                System.out.println("Workout in min: " + myRs.getString("total"));
            }
            myRs = myStmt.executeQuery(sqlDistinct);
            while (myRs.next()) {
                System.out.println("Number of different exercises: " + myRs.getString("total"));
            }
            myRs = myStmt.executeQuery(sqlAvg);
            while (myRs.next()) {
                System.out.println("Avg. performance: " + myRs.getString("total"));
            }
        }
    }

    // Usecase 3: Registrer workout.
    public void registerWorkout(Scanner scanner) throws SQLException {
        // 1. Be brukeren oppgi verdier for dato og varighet.  Vær, temp, tilskuere, form, prestasjon og notat er valgfritt.  Trykker enter for å la disse stå blankt.
        System.out.print("Enter date (format: YYYYMMDD): ");
        String date = scanner.nextLine();
        System.out.print("Enter duration in min: ");
        int duration = Integer.parseInt(scanner.nextLine());
        System.out.println("Enter temperature: ");
        int temp = Integer.parseInt(scanner.nextLine());
        System.out.println("Enter pulse: ");
        int pulse = Integer.parseInt(scanner.nextLine());
        System.out.println("Enter longitude: ");
        int longitude = Integer.parseInt(scanner.nextLine());
        System.out.println("Enter latitude: ");
        int latitude = Integer.parseInt(scanner.nextLine());
        System.out.println("Enter altitude: ");
        int altitude = Integer.parseInt(scanner.nextLine());

        String sql = "Insert into Workout (date, duration, temperature, pulse, longitude, latitude, altitude) values ("
                + date + ", " + duration + ", " + temp + "," + pulse + "," + longitude + "," + latitude + "," +
                altitude + ")";
        myStmt.executeUpdate(sql);
        // 2. Spørre brukeren om han vil legge til øvelse som er gjennomført i økten.

        while (true) {
            System.out.println("Do you want to enter an exercise for this workout? (y/n): ");
            String ans = scanner.nextLine();
            if (ans.toLowerCase().equals("n")) break;
            else {
                sql = "select exerciseID, name from Exercise";
                ResultSet myRs = myStmt.executeQuery(sql);
                while (myRs.next()) {
                    System.out.println(myRs.getString("exerciseID") + ": " +  myRs.getString("name"));
                }
                System.out.println("\nSelect exercise:");
                int exerciseID = Integer.parseInt(scanner.nextLine());


                System.out.println("Enter load: ");
                int load = Integer.parseInt(scanner.nextLine());
                System.out.println("Enter sets: ");
                int sets = Integer.parseInt(scanner.nextLine());
                System.out.println("Enter repetitions: ");
                int reps = Integer.parseInt(scanner.nextLine());
                System.out.println("Enter length: ");
                int length = Integer.parseInt(scanner.nextLine());
                System.out.println("Enter duration: ");
                int exerciseDuration = Integer.parseInt(scanner.nextLine());

                sql = "INSERT INTO Checklist Values (" + date + ", " + exerciseID +
                        ", " + load + ", " + sets + ", " + reps +
                        ", " + length + ", " + exerciseDuration + ")";
                myStmt.executeUpdate(sql);
            }
        }
    }

    // Usecase 4: Legger inn nye øvelser
    public void registerExercise(Scanner scanner) throws SQLException {

        while (true) {
            System.out.print("Name of exercise: ");
            String name = scanner.nextLine();
            System.out.print("description: ");
            String description = scanner.nextLine();

            String sql = "insert into Exercise (name, description) values " + "('" + name + "', '" + description + "')";
            myStmt.executeUpdate(sql);
            System.out.println("Exercise '" + name + "' is now registered!");

            System.out.println("Do you want to add another exercise? [y/n]");
            String answ = scanner.nextLine();
            if (answ.toUpperCase().equals("N")) { break;}
            else {continue;}

        }

    }

    // Usecase 5: Legg inn mål for øvelser
    public void registerGoal(Scanner scanner) throws SQLException {

        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, 1);
        SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");
        cal.setTimeZone(TimeZone.getTimeZone("Europe/Oslo"));
        String formattedDate = format1.format(cal.getTime());

        while (true) {
            String sql = "select exerciseID, name from Exercise";
            ResultSet myRs = myStmt.executeQuery(sql);
            while (myRs.next()) {
                System.out.println(myRs.getString("exerciseID") + ": " +  myRs.getString("name"));
            }
            System.out.print("\nChoose exercise ");
            int exerciseID = Integer.parseInt(scanner.nextLine());

            System.out.println("\nIs this a:\nS: Strength-exercise\nC: Condition-exercise");
            String exercise = scanner.nextLine();

            String exerc = "";
            sql = "select name from Exercise where exerciseID = " + exerciseID;
            myRs = myStmt.executeQuery(sql);
            while (myRs.next()) {
                exerc = myRs.getString("name");
            }

            System.out.println("You have chosen to set goal for '" + exerc + "'");
            if (exerc.toUpperCase().equals("S")) {// Styrke
                System.out.print("Enter load: ");
                String belastning = scanner.nextLine();
                System.out.print("Enter number of sets: ");
                String sett = scanner.nextLine();
                System.out.print("Enter number of repetitions: ");
                String reps = scanner.nextLine();
                //System.out.println("Enter todays date in the format YYYYMMDD");
                //String dato = scanner.nextLine();

                sql = "insert into Goal (exerciseID, creationDate, totLoad, totSets, totRepetitions, achieved) values "
                        + "(" + exerciseID + ", " + formattedDate + ", " + belastning + ", " + sett + ", "	+ reps + ", " + "0)";

                myStmt.executeUpdate("Update Goal set achieved = 1 where exerciseID = " + exerciseID); // Setter de andre målene lik 1.
                myStmt.executeUpdate(sql);
            }
            else {// Kondisjon
                System.out.print("Enter duration: ");
                String durat = scanner.nextLine();
                //System.out.println("Enter todays date in the format YYYYMMDD");
                //String dato = scanner.nextLine();

                sql = "insert into Goal (exerciseID, creationDate, duration, achieved) values" +
                        "(" + exerciseID + ", " + formattedDate + ", " + durat + ", 0)";

                myStmt.executeUpdate("Update Goal set achieved = 1 where exerciseID = " + exerciseID); // Setter de andre målene lik null.
                myStmt.executeUpdate(sql);
            }

            System.out.println("Do you want to add a goal for another exercise? [y/n]");
            String ans = scanner.nextLine();
            if (ans.toUpperCase().equals("N")) { break;}
        }

    }
}
