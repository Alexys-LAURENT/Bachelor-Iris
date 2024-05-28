package com.example.mybongeste;

public class Todo {
    private int idTodo, idUser;
    private String description, timestamp,etat;

    public Todo(int idTodo, int idUser, String description, String timestamp, String etat) {
        this.idTodo = idTodo;
        this.idUser = idUser;
        this.description = description;
        this.timestamp = timestamp;
        this.etat = etat;
    }

    public Todo(String description, String timestamp, String etat) {
        this.description = description;
        this.timestamp = timestamp;
        this.etat = etat;
    }

    public Todo() {
    }

    public String stringify(){
        return this.idTodo+";"+this.idUser+";"+this.description+";"+this.timestamp+";"+this.etat+";";
    }

    public void construire(String stringedTodo){
        String[] tab = stringedTodo.split(";");
        this.idTodo = Integer.parseInt(tab[0]);
        this.idUser = Integer.parseInt(tab[1]);
        this.description = tab[2];
        this.timestamp = tab[3];
        this.etat = tab[4];
    }

    public int getIdTodo() {
        return idTodo;
    }

    public void setIdTodo(int idTodo) {
        this.idTodo = idTodo;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getEtat() {
        return etat;
    }

    public void setEtat(String etat) {
        this.etat = etat;
    }
}
