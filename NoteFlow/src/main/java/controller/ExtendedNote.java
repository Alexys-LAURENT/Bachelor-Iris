package controller;

public class ExtendedNote extends Note {
    private String libelle;
    private String hex;

    public ExtendedNote() {
        super();
        this.libelle = "";
        this.hex = "";
    }

    public ExtendedNote(int idNote, String titre, String content, int idCategorie, int isFavorite, String libelle, String hex) {
        super(idNote, titre, content,idCategorie, isFavorite);
        this.libelle = libelle;
        this.hex = hex;
    }

    public ExtendedNote(String titre, String content, int idCategorie, int isFavorite, String libelle, String hex) {
        super(titre, content,idCategorie, isFavorite);
        this.libelle = libelle;
        this.hex = hex;
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
}
