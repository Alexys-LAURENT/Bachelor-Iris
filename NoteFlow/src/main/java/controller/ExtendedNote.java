package controller;

import java.sql.Timestamp;

public class ExtendedNote extends Note {
    private String libelle;
    private String hex;
    private Timestamp timestamp;

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
}
