using TicketNamespace;
using UserNamespace;
using MessageNamespace;
namespace Carnet
{
    public class Controleur
    {
        private static Modele unModele = new Modele("", "", "", "");
        public static List<Ticket> GetAllTickets(string application, string titre, string description)
        {
            return unModele.GetAllTickets(application, titre, description);
        }

        public static User GetUser(string token)
        {
            return unModele.GetUser(token);
        }

        public static bool IsTechnicien(int idUser)
        {
            return unModele.IsTechnicien(idUser);
        }

        public static List<Ticket> GetTicketsTechnicien(int idUser)
        {
            return unModele.GetTicketsTechnicien(idUser);
        }

        public static List<Ticket> GetTicketsUser(int idUser)
        {
            return unModele.GetTicketsUser(idUser);
        }

        public static Ticket GetTicket(int idTicket)
        {
            return unModele.GetTicket(idTicket);
        }

        public static void ResolveTicket(int idTicket, string MessageResolution)
        {
            unModele.ResolveTicket(idTicket, MessageResolution);
        }

        public static List<Message> GetMessagesTicket(int idTicket)
        {
            return unModele.GetMessagesTicket(idTicket);
        }

        public static void SendMessage(int idUser, int idTicket, string content)
        {
            unModele.SendMessage(idUser, idTicket, content);
        }

        public static int OpenNewTicket(int idUser, string title, string content, string application)
        {
            return unModele.OpenNewTicket(idUser, title, content, application);
        }

        public static void ToggleDarkMode(int idUser)
        {
            unModele.ToggleDarkMode(idUser);
        }
    }
}
