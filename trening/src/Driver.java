import java.sql.*;
import java.util.Scanner;

public class Driver {


    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        try {
            Connection myConn =  DriverManager.getConnection("jdbc:mysql://mysql.stud.ntnu.no/aleksahh_Group83_WorkDiary", "aleksahh_WorkDia", "CourseTracker"); // Endre her!
            Statement myStmt = myConn.createStatement();
            Actions action = new Actions(myConn, myStmt);

            while (true) {
                System.out.println("\nWhat would you like to view?");
                System.out.println("\n1. Records\n"
                        + "2. Information about past exercises\n"
                        + "3. Register workout\n"
                        + "4. Register exercise\n"
                        + "5. Register goal\n"
                        + "6. Exit");


                int ans = Integer.parseInt(scanner.nextLine());

                if (ans == 1) {
                    action.records(scanner);
                }
                else if (ans == 2) {
                    action.workout(scanner);
                }
                else if (ans == 3) {
                    action.registerWorkout(scanner);
                }
                else if (ans == 4) {
                    action.registerExercise(scanner);
                }
                else if (ans == 5) {
                    action.registerGoal(scanner);
                }
                else {
                    break;
                }
            }
            scanner.close();
        }
        catch (Exception exc) {
            System.out.println("Somewhere, something went horribly wrong.... O.O ");
            exc.printStackTrace();
        }
    }
}
