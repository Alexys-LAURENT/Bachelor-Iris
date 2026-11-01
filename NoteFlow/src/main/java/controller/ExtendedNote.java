package controller;

import java.sql.Timestamp;

public class ExtendedNote extends Note {
    private String libelle;
    private String hex;
    private Timestamp timestamp;
    private String nom;
    private String prenom;

    public ExtendedNote() {
        super();
        this.libelle = "";
        this.hex = "";
        this.timestamp = null;
    }

    public ExtendedNote(int idNote, String titre, String content, int idCategorie, int isFavorite, String libelle,
            String hex, Timestamp timestamp) {
        super(idNote, titre, content, idCategorie, isFavorite);
        this.libelle = libelle;
        this.hex = hex;
        this.timestamp = timestamp;
    }

    public ExtendedNote(String titre, String content, int idCategorie, int isFavorite, String libelle, String hex,
            Timestamp timestamp) {
        super(titre, content, idCategorie, isFavorite);
        this.libelle = libelle;
        this.hex = hex;
        this.timestamp = timestamp;
    }

    public ExtendedNote(int idNote, String titre, String content, int idCategorie, int isFavorite, String libelle,
            String hex, Timestamp timestamp, String nom, String prenom) {
        super(idNote, titre, content, idCategorie, isFavorite);
        this.libelle = libelle;
        this.hex = hex;
        this.timestamp = timestamp;
        this.nom = nom;
        this.prenom = prenom;
    }

    public String getLibelle() {
        return this.libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public String getHex() {
        return this.hex;
    }

    public void setHex(String hex) {
        this.hex = hex;
    }

    public Timestamp getTimestamp() {
        return this.timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    public String getNom() {
        return this.nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return this.prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }
}
