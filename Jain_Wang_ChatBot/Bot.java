import java.util.Scanner;

public class Bot
{
    public static void main(String args[])
    {
        System.out.println("\nWelcome to ChatBot!");
        System.out.println("Ask me anything by typing below. Type 'QUIT' to end the program.\n");
        Scanner sc = new Scanner(System.in);
        System.out.print("You: ");
        String input = sc.nextLine();
        while(!input.equals("QUIT"))
        {
            System.out.println("Bot: " + response(input));
            System.out.print("You: ");
            input = sc.nextLine();
        }
        System.out.println("\nChatbot program has been quit.\n");
    }
    
    private static String response(String text)
    {
        return "Insert response here.";
    }
}