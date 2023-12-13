package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connexion {
    private String serveur, bdd, user, mdp;

    private Connection maConnexion;

    public Connexion(String serveur, String bdd, String user, String mdp) {
        super();
        this.serveur = serveur;
        this.bdd = bdd;
        this.user = user;
        this.mdp = mdp;
        this.maConnexion = null;
    }

    public void chargerPilote() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException exp) {
            System.out.println("Erreur de chargement du driver : " + exp);
        }
    }


    public void seConnecter() {
        this.chargerPilote();
        //String url = "jdbc:mysql://" + this.serveur + "/" + this.bdd;
        String url = "jdbc:mysql://" + this.serveur + "/" + this.bdd;
        try {
            this.maConnexion = DriverManager.getConnection(url, this.user, this.mdp);
        } catch (SQLException exp) {
            System.out.println("Erreur de connexion à la BDD : " + exp.getMessage());
            exp.printStackTrace();
        }
    }


    public void seDeconnecter() {
        try {
            if (this.maConnexion != null) {
                this.maConnexion.close();
                ;
            }
        } catch (SQLException exp) {
            System.out.println("Erreur de déconnexion de la BDD : " + exp);
        }
    }

    public Connection getMaConnexion() {
        return this.maConnexion;
    }
}
