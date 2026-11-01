package controller;

public class User {
    private int idUser;
    private String nom;
    private String prenom;
    private String metier;
    private String pp;
    private String email;
    private String theme;
    private String statut;

    public User(int idUser, String nom, String prenom, String metier, String pp, String email, String theme,
            String statut) {
        this.idUser = idUser;
        this.nom = nom;
        this.prenom = prenom;
        this.metier = metier;
        this.pp = pp;
        this.email = email;
        this.theme = theme;
        this.statut = statut;
    }

	public int getIdUser() {
		return idUser;
	}

	public void setIdUser(int idUser) {
		this.idUser = idUser;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPrenom() {
		return prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

	public String getMetier() {
		return metier;
	}

	public void setMetier(String metier) {
		this.metier = metier;
	}

	public String getPp() {
		return pp;
	}

	public void setPp(String pp) {
		this.pp = pp;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}

	public String getStatut() {
		return statut;
	}

	public void setStatut(String statut) {
		this.statut = statut;
	}

    // getters and setters for each field

}
