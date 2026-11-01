package controller;

public class Shares {
    private int idShare, idNote, idOwner, idShared;
    private String permissions;

    public Shares() {
        this.idShare = 0;
        this.idNote = 0;
        this.idOwner = 0;
        this.idShared = 0;
        this.permissions = "";
    }

    public Shares(int idShare, int idNote, int idOwner, int idShared, String permissions) {
        this.idShare = idShare;
        this.idNote = idNote;
        this.idOwner = idOwner;
        this.idShared = idShared;
        this.permissions = permissions;
    }

    public Shares(int idNote, int idOwner, int idShared, String permissions) {
        this.idNote = idNote;
        this.idOwner = idOwner;
        this.idShared = idShared;
        this.permissions = permissions;
    }

    public int getIdShare() {
        return this.idShare;
    }

    public void setIdShare(int idShare) {
        this.idShare = idShare;
    }

    public int getIdNote() {
        return this.idNote;
    }

    public void setIdNote(int idNote) {
        this.idNote = idNote;
    }

    public int getIdOwner() {
        return this.idOwner;
    }

    public void setIdOwner(int idOwner) {
        this.idOwner = idOwner;
    }

    public int getIdShared() {
        return this.idShared;
    }

    public void setIdShared(int idShared) {
        this.idShared = idShared;
    }

    public String getPermissions() {
        return this.permissions;
    }

    public void setPermissions(String permissions) {
        this.permissions = permissions;
    }
}
