namespace UserNamespace
{
    public class User
    {
        public int IdUser { get; set; }
        public int IdEntreprise { get; set; }
        public int IdManager { get; set; }
        public string Nom { get; set; }
        public string Prenom { get; set; }
        public string Email { get; set; }
        public string HashedPass { get; set; }
        public string Metier { get; set; }
        public string Pp { get; set; }
        public string Theme { get; set; }
        public string Statut { get; set; }
        public User(int IdUser, int IdEntreprise, int IdManager, string Nom, string Prenom, string Email, string HashedPass, string Metier, string Pp, string Theme, string Statut)
        {
            this.IdUser = IdUser; //this.setID(id);
            this.IdEntreprise = IdEntreprise;
            this.IdManager = IdManager;
            this.Nom = Nom;
            this.Prenom = Prenom;
            this.Email = Email;
            this.HashedPass = HashedPass;
            this.Metier = Metier;
            this.Pp = Pp;
            this.Theme = Theme;
            this.Statut = Statut;
        }

        public User(int IdEntreprise, int IdManager, string Nom, string Prenom, string Email, string HashedPass, string Metier, string Pp, string Theme, string Statut)
        {
            this.IdUser = 0; //this.setID(id);
            this.IdEntreprise = IdEntreprise;
            this.IdManager = IdManager;
            this.Nom = Nom;
            this.Prenom = Prenom;
            this.Email = Email;
            this.HashedPass = HashedPass;
            this.Metier = Metier;
            this.Pp = Pp;
            this.Theme = Theme;
            this.Statut = Statut;
        }

    }

}