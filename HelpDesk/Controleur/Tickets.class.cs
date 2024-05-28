namespace TicketNamespace
{
    public class Ticket
    {
        public int IdTicket { get; set; }
        public int IdUser { get; set; }
        public int IdTechnicien { get; set; }
        public int IdApplication { get; set; }
        public string Titre { get; set; }
        public string Description { get; set; }
        public string Etat { get; set; }

        public string MessageResolution { get; set; }
        public Ticket(int IdTicket, int IdUser, int IdApplication, string Titre, string Description, string Etat, int IdTechnicien, string MessageResolution)
        {
            this.IdTicket = IdTicket; //this.setID(id);
            this.IdUser = IdUser;
            // this.IdTechnicien = IdTechnicien;
            this.IdApplication = IdApplication;
            this.Titre = Titre;
            this.Description = Description;
            this.Etat = Etat;
            this.IdTechnicien = IdTechnicien;
            this.MessageResolution = MessageResolution;
        }

        public Ticket(int IdUser, int IdApplication, string Titre, string Description, string Etat, int IdTechnicien, string MessageResolution)
        {
            this.IdTicket = 0; //this.setID(id);
            this.IdUser = IdUser;
            // this.IdTechnicien = IdTechnicien;
            this.IdApplication = IdApplication;
            this.Titre = Titre;
            this.Description = Description;
            this.Etat = Etat;
            this.IdTechnicien = IdTechnicien;
            this.MessageResolution = MessageResolution;
        }

    }
}
