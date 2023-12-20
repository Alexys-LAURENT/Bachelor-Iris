package controller;

public class Share {
    private int idShare, idNote, idOwner, idShared;
    private String prenom, nom, pp, permissions;

    public Share(int idShare, int idNote, int idOwner, int idShared, String prenom, String nom, String pp,
            String permissions) {
        this.idShare = idShare;
        this.idNote = idNote;
        this.idOwner = idOwner;
        this.idShared = idShared;
        this.prenom = prenom;
        this.nom = nom;
        this.pp = pp;
        this.permissions = permissions;
    }

    public int getIdShare() {
        return idShare;
    }

    public void setIdShare(int idShare) {
        this.idShare = idShare;
    }

    public int getIdNote() {
        return idNote;
    }

    public void setIdNote(int idNote) {
        this.idNote = idNote;
    }

    public int getIdOwner() {
        return idOwner;
    }

    public void setIdOwner(int idOwner) {
        this.idOwner = idOwner;
    }

    public int getIdShared() {
        return idShared;
    }

    public void setIdShared(int idShared) {
        this.idShared = idShared;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getPp() {
        return pp;
    }

    public void setPp(String pp) {
        this.pp = pp;
    }

    public void setPermissions(String permissions) {
        this.permissions = permissions;
    }

    public String getPermissions() {
        return permissions;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
}
