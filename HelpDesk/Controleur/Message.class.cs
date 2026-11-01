namespace MessageNamespace
{
    public class Message
    {
        public int IdMessageTicket { get; set; }
        public int IdUser { get; set; }
        public int IdTicket { get; set; }

        public DateTime Timestamp { get; set; }
        public string Content { get; set; }
        public Message(int IdMessageTicket, int IdUser, int IdTicket, DateTime Timestamp, string Content)
        {
            this.IdMessageTicket = IdMessageTicket; //this.setID(id);
            this.IdUser = IdUser;
            this.IdTicket = IdTicket;
            this.Timestamp = Timestamp;
            this.Content = Content;
        }

        public Message(int IdUser, int IdTicket, DateTime Timestamp, string Content)
        {
            this.IdMessageTicket = 0; //this.setID(id);
            this.IdUser = IdUser;
            this.IdTicket = IdTicket;
            this.Timestamp = Timestamp;
            this.Content = Content;
        }

    }

}