package controller;

public class Tag {
    private int idTag;
    private String libelle;
    private String hex;

    public Tag() {
        this.idTag = 0;
        this.libelle = "";
        this.hex = "";
    }

    public Tag(int idTag, String libelle, String hex) {
        this.idTag = idTag;
        this.libelle = libelle;
        this.hex = hex;
    }

    public Tag(String libelle, String hex) {
        this.libelle = libelle;
        this.hex = hex;
    }

    public int getIdTag() {
        return this.idTag;
    }

    public void setIdTag(int idTag) {
        this.idTag = idTag;
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
