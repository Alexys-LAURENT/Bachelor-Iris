package com.example.mybongeste;

import android.media.tv.PesRequest;

public class Personne {
    private int idUser, idEntreprise ;
    private String nom,hashedPass, prenom, email, pp;

    public Personne(int idUser, int idEntreprise, String nom, String prenom, String email, String pp) {
        this.idUser = idUser;
        this.idEntreprise = idEntreprise;
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.pp = pp;
    }

    public Personne(String nom, String prenom, String email, String pp) {
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.pp = pp;
    }

    public Personne() {
        this.nom = "";
        this.prenom = "";
        this.email = "";
        this.hashedPass = "";
        this.pp = "";
    }

    public Personne(String email, String hashedPass) {
        this.email = email;
        this.hashedPass = hashedPass;
        this.nom = "";
        this.prenom = "";
        this.pp = "";
        this.idUser = 0;
        this.idEntreprise = 0;
    }

    public String stringify(){
        return this.idUser+";"+this.nom+";"+this.prenom+";"+this.email+";"+this.pp+";";
    }

    public void construire(String stringedUser){
        String[] tab = stringedUser.split(";");
        this.idUser = Integer.parseInt(tab[0]);
        this.nom = tab[1];
        this.prenom = tab[2];
        this.email = tab[3];
        this.pp = tab[4];
    }



    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public int getIdEntreprise() {
        return idEntreprise;
    }

    public void setIdEntreprise(int idEntreprise) {
        this.idEntreprise = idEntreprise;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getHashedPass() {
        return hashedPass;
    }

    public void setHashedPass(String hashedPass) {
        this.hashedPass = hashedPass;
    }

    public String getPp() {
        return pp;
    }

    public void setPp(String pp) {
        this.pp = pp;
    }

}
