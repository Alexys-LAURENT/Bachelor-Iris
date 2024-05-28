using MySql.Data.MySqlClient;
using System.Diagnostics;
using TicketNamespace;
using UserNamespace;
using MessageNamespace;

namespace Carnet
{
    public class Modele
    {
        private string serveur, bdd, user, mdp;
        private MySqlConnection maConnexion;
        public Modele(string serveur, string bdd, string user, string mdp)
        {
            this.serveur = serveur;
            this.bdd = bdd;
            this.user = user;
            this.mdp = mdp;
            string url = "SslMode=Required; SERVER=" + this.serveur;
            url += "; Port=3306";
            url += "; Database=" + this.bdd;
            url += "; User Id=" + this.user;
            url += "; Password=" + this.mdp;
            try
            {
                this.maConnexion = new MySqlConnection(url);

            }
            catch (Exception exp)
            {
                Console.WriteLine("Erreur de connexion a : " + url + " : " + exp);
            }
        }

        public User GetUser(string token)
        {
            try
            {
                try { this.maConnexion.Close(); } catch (Exception) { }
                this.maConnexion.Open();
                MySqlCommand command = this.maConnexion.CreateCommand();
                command.CommandText = "SELECT * FROM users WHERE idUser = (SELECT idUser FROM token WHERE token = @token AND expireAt > NOW())";
                command.Parameters.AddWithValue("@token", token);
                User user = null;
                using (MySqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        int id = reader.GetInt32(0);
                        int value1 = reader.IsDBNull(1) ? 0 : reader.GetInt32(1);
                        int value2 = reader.IsDBNull(2) ? 0 : reader.GetInt32(2);
                        string value3 = reader.IsDBNull(3) ? string.Empty : reader.GetString(3);
                        string value4 = reader.IsDBNull(4) ? string.Empty : reader.GetString(4);
                        string value5 = reader.IsDBNull(5) ? string.Empty : reader.GetString(5);
                        string value6 = reader.IsDBNull(6) ? string.Empty : reader.GetString(6);
                        string value7 = reader.IsDBNull(7) ? string.Empty : reader.GetString(7);
                        string value8 = reader.IsDBNull(8) ? string.Empty : reader.GetString(8);
                        string value9 = reader.IsDBNull(9) ? string.Empty : reader.GetString(9);
                        string value10 = reader.IsDBNull(10) ? string.Empty : reader.GetString(10);

                        user = new User(id, value1, value2, value3, value4, value5, value6, value7, value8, value9, value10);
                    }
                }
                this.maConnexion.Close();

                return user;
            }
            catch (Exception exp)
            {
                Console.WriteLine("Erreur de connexion a : " + exp);
            }
            return null;
        }

        public bool IsTechnicien(int idUser)
        {
            try
            {
                try { this.maConnexion.Close(); } catch (Exception) { }
                this.maConnexion.Open();
                MySqlCommand command = this.maConnexion.CreateCommand();
                command.CommandText = "SELECT * FROM supports WHERE idSupport = @idUser";
                command.Parameters.AddWithValue("@idUser", idUser);
                bool isTechnicien = false;
                using (MySqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        isTechnicien = true;
                    }
                }
                this.maConnexion.Close();

                return isTechnicien;
            }
            catch (Exception exp)
            {
                Debug.WriteLine("Erreur de connexion a : " + exp);
            }
            return false;
        }

        public List<Ticket> GetAllTickets(string application, string titre, string description)
        {
            try
            {
                try { this.maConnexion.Close(); } catch (Exception) { }
                this.maConnexion.Open();
                MySqlCommand command = this.maConnexion.CreateCommand();
                if (application == "All")
                {
                    command.CommandText = "SELECT * FROM tickets WHERE idTechnicien is null and titre LIKE @titre AND description LIKE @description order by etat, idTicket desc";
                }
                else
                {
                    command.CommandText = "SELECT * FROM tickets WHERE idTechnicien is null and titre LIKE @titre AND description LIKE @description AND idApplication = (SELECT idApplication FROM applications WHERE nom = @application) order by etat, idTicket desc";
                    command.Parameters.AddWithValue("@application", application);
                }
                command.Parameters.AddWithValue("@titre", "%" + titre + "%");
                command.Parameters.AddWithValue("@description", "%" + description + "%");

                // new arraylist of tickets
                List<Ticket> tickets = new List<Ticket>();
                using (MySqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        int id = reader.GetInt32(0);
                        int value1 = reader.IsDBNull(1) ? 0 : reader.GetInt32(1);
                        int value2 = reader.IsDBNull(2) ? 0 : reader.GetInt32(2);
                        string value3 = reader.IsDBNull(3) ? string.Empty : reader.GetString(3);
                        string value4 = reader.IsDBNull(4) ? string.Empty : reader.GetString(4);
                        string value5 = reader.IsDBNull(5) ? string.Empty : reader.GetString(5);
                        int value6 = reader.IsDBNull(6) ? 0 : reader.GetInt32(6);
                        string value7 = reader.IsDBNull(7) ? string.Empty : reader.GetString(7);

                        Ticket ticket = new Ticket(id, value1, value2, value3, value4, value5, value6, value7);
                        tickets.Add(ticket);
                    }
                }
                this.maConnexion.Close();

                return tickets;
            }
            catch (Exception exp)
            {
                Debug.WriteLine("Erreur de connexion a : " + exp);
            }
            return null;
        }

        public List<Ticket> GetTicketsTechnicien(int idUser)
        {
            try
            {
                try { this.maConnexion.Close(); } catch (Exception) { }
                this.maConnexion.Open();
                MySqlCommand command = this.maConnexion.CreateCommand();
                command.CommandText = "SELECT * FROM tickets WHERE idTechnicien = @idUser and etat not like 'Terminé'";
                command.Parameters.AddWithValue("@idUser", idUser);
                // new arraylist of tickets
                List<Ticket> tickets = new List<Ticket>();
                using (MySqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        int id = reader.GetInt32(0);
                        int value1 = reader.IsDBNull(1) ? 0 : reader.GetInt32(1);
                        int value2 = reader.IsDBNull(2) ? 0 : reader.GetInt32(2);
                        string value3 = reader.IsDBNull(3) ? string.Empty : reader.GetString(3);
                        string value4 = reader.IsDBNull(4) ? string.Empty : reader.GetString(4);
                        string value5 = reader.IsDBNull(5) ? string.Empty : reader.GetString(5);
                        int value6 = reader.IsDBNull(6) ? 0 : reader.GetInt32(6);
                        string value7 = reader.IsDBNull(7) ? string.Empty : reader.GetString(7);

                        Ticket ticket = new Ticket(id, value1, value2, value3, value4, value5, value6, value7);
                        tickets.Add(ticket);
                    }
                }
                this.maConnexion.Close();

                return tickets;
            }
            catch (Exception exp)
            {
                Debug.WriteLine("Erreur de connexion a : " + exp);
            }
            return null;
        }

        public List<Ticket> GetTicketsUser(int idUser)
        {
            try
            {
                try { this.maConnexion.Close(); } catch (Exception) { }
                this.maConnexion.Open();
                MySqlCommand command = this.maConnexion.CreateCommand();
                command.CommandText = "SELECT * FROM tickets WHERE idUser = @idUser order by etat, idTicket desc";
                command.Parameters.AddWithValue("@idUser", idUser);
                // new arraylist of tickets
                List<Ticket> tickets = new List<Ticket>();
                using (MySqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        int id = reader.GetInt32(0);
                        int value1 = reader.IsDBNull(1) ? 0 : reader.GetInt32(1);
                        int value2 = reader.IsDBNull(2) ? 0 : reader.GetInt32(2);
                        string value3 = reader.IsDBNull(3) ? string.Empty : reader.GetString(3);
                        string value4 = reader.IsDBNull(4) ? string.Empty : reader.GetString(4);
                        string value5 = reader.IsDBNull(5) ? string.Empty : reader.GetString(5);
                        int value6 = reader.IsDBNull(6) ? 0 : reader.GetInt32(6);
                        string value7 = reader.IsDBNull(7) ? string.Empty : reader.GetString(7);

                        Ticket ticket = new Ticket(id, value1, value2, value3, value4, value5, value6, value7);
                        tickets.Add(ticket);
                    }
                }
                this.maConnexion.Close();

                return tickets;
            }
            catch (Exception exp)
            {
                Debug.WriteLine("Erreur de connexion a : " + exp);
            }
            return null;
        }

        public Ticket GetTicket(int idTicket)
        {
            try
            {
                try { this.maConnexion.Close(); } catch (Exception) { }
                this.maConnexion.Open();
                MySqlCommand command = this.maConnexion.CreateCommand();
                command.CommandText = "SELECT * FROM tickets WHERE idTicket = @idTicket";
                command.Parameters.AddWithValue("@idTicket", idTicket);
                Ticket ticket = null;
                using (MySqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        int id = reader.GetInt32(0);
                        int value1 = reader.IsDBNull(1) ? 0 : reader.GetInt32(1);
                        int value2 = reader.IsDBNull(2) ? 0 : reader.GetInt32(2);
                        string value3 = reader.IsDBNull(3) ? string.Empty : reader.GetString(3);
                        string value4 = reader.IsDBNull(4) ? string.Empty : reader.GetString(4);
                        string value5 = reader.IsDBNull(5) ? string.Empty : reader.GetString(5);
                        int value6 = reader.IsDBNull(6) ? 0 : reader.GetInt32(6);
                        string value7 = reader.IsDBNull(7) ? string.Empty : reader.GetString(7);

                        ticket = new Ticket(id, value1, value2, value3, value4, value5, value6, value7);
                    }
                }
                this.maConnexion.Close();

                return ticket;
            }
            catch (Exception exp)
            {
                Debug.WriteLine("Erreur de connexion a : " + exp);
            }
            return null;
        }

        public void ResolveTicket(int idTicket, string MessageResolution)
        {
            try
            {
                try { this.maConnexion.Close(); } catch (Exception) { }
                this.maConnexion.Open();
                MySqlCommand command = this.maConnexion.CreateCommand();
                command.CommandText = "UPDATE tickets SET etat = 'Terminé', messageResolution = @MessageResolution WHERE idTicket = @idTicket";
                command.Parameters.AddWithValue("@idTicket", idTicket);
                command.Parameters.AddWithValue("@MessageResolution", MessageResolution);
                command.ExecuteNonQuery();
                this.maConnexion.Close();
            }
            catch (Exception exp)
            {
                Debug.WriteLine("Erreur de connexion a : " + exp);
            }
        }

        public List<Message> GetMessagesTicket(int idTicket)
        {
            try
            {
                try { this.maConnexion.Close(); } catch (Exception) { }
                this.maConnexion.Open();
                MySqlCommand command = this.maConnexion.CreateCommand();
                command.CommandText = "SELECT * FROM messages_tickets WHERE idTicket = @idTicket";
                command.Parameters.AddWithValue("@idTicket", idTicket);
                // new arraylist of messages
                List<Message> messages = new List<Message>();
                using (MySqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Message message = new Message(reader.GetInt32(0), reader.GetInt32(1), reader.GetInt32(2), reader.GetDateTime(3), reader.GetString(4));
                        messages.Add(message);
                    }
                }
                this.maConnexion.Close();

                return messages;
            }
            catch (Exception exp)
            {
                Debug.WriteLine("Erreur de connexion a : " + exp);
            }
            return null;
        }

        public void SendMessage(int idUser, int idTicket, string content)
        {
            try
            {
                bool technicien = IsTechnicien(idUser);

                if (technicien)
                {
                    try { this.maConnexion.Close(); } catch (Exception) { }
                    this.maConnexion.Open();
                    MySqlCommand command2 = this.maConnexion.CreateCommand();

                    command2.CommandText = "Select idTechnicien FROM tickets WHERE idTicket = @idTicket";
                    command2.Parameters.AddWithValue("@idTicket", idTicket);
                    object result = command2.ExecuteScalar();
                    int? idTechnicien = Convert.IsDBNull(result) ? null : Convert.ToInt32(result);

                    if (idTechnicien == null)
                    {
                        MySqlCommand command3 = this.maConnexion.CreateCommand();
                        command3.CommandText = "UPDATE tickets SET idTechnicien = @idUser WHERE idTicket = @idTicket";
                        command3.Parameters.AddWithValue("@idUser", idUser);
                        command3.Parameters.AddWithValue("@idTicket", idTicket);
                        command3.ExecuteNonQuery();
                    }
                }

                try { this.maConnexion.Close(); } catch (Exception) { }
                this.maConnexion.Open();

                MySqlCommand command = this.maConnexion.CreateCommand();
                command.CommandText = "INSERT INTO messages_tickets (idUser, idTicket, timestamp, content) VALUES (@idUser, @idTicket, NOW(), @content)";
                command.Parameters.AddWithValue("@idUser", idUser);
                command.Parameters.AddWithValue("@idTicket", idTicket);
                command.Parameters.AddWithValue("@content", content);
                command.ExecuteNonQuery();
                this.maConnexion.Close();
            }
            catch (Exception exp)
            {
                Debug.WriteLine("Erreur de connexion a : " + exp);
            }
        }

        public int OpenNewTicket(int idUser, string title, string description, string application)
        {
            int newTicketId = 0;
            try
            {
                try { this.maConnexion.Close(); } catch (Exception) { }
                this.maConnexion.Open();
                MySqlCommand command = this.maConnexion.CreateCommand();
                command.CommandText = "INSERT INTO tickets (idUser, titre, description, idApplication, etat) VALUES (@idUser, @titre, @description, (SELECT idApplication FROM applications WHERE nom = @application), 'En Cours'); SELECT LAST_INSERT_ID();";
                command.Parameters.AddWithValue("@idUser", idUser);
                command.Parameters.AddWithValue("@titre", title);
                command.Parameters.AddWithValue("@description", description);
                command.Parameters.AddWithValue("@application", application);
                newTicketId = Convert.ToInt32(command.ExecuteScalar());
                this.maConnexion.Close();
            }
            catch (Exception exp)
            {
                Debug.WriteLine("Erreur de connexion a : " + exp);
            }
            return newTicketId;
        }

        public void ToggleDarkMode(int idUser)
        {
            try
            {
                try { this.maConnexion.Close(); } catch (Exception) { }
                this.maConnexion.Open();
                MySqlCommand command = this.maConnexion.CreateCommand();
                command.CommandText = "UPDATE users SET theme = (CASE WHEN theme = 'dark' THEN 'light' ELSE 'dark' END) WHERE idUser = @idUser";
                command.Parameters.AddWithValue("@idUser", idUser);
                command.ExecuteNonQuery();
                this.maConnexion.Close();
            }
            catch (Exception exp)
            {
                Debug.WriteLine("Erreur de connexion a : " + exp);
            }
        }
    }
}