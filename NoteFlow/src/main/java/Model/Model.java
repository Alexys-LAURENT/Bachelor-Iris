package model;

import java.util.ArrayList;

import controller.Note;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Model {
    private static Connexion maConnexion = new Connexion("localhost:3306",
            "syncpro", "root", "");

    /******************* GESTION DES CLIENTS *******************/
    // public static void insertClient(Client unClient) {
    // String req = "insert into client values(null,'"
    // + unClient.getNom() + "','"
    // + unClient.getPrenom() + "','"
    // + unClient.getAdresse() + "');";
    // try {
    // maConnexion.seConnecter();
    // Statement unStat = maConnexion.getMaConnexion().createStatement();
    // unStat.execute(req);
    // unStat.close();
    // maConnexion.seDeconnecter();
    // } catch (SQLException exp) {
    // System.out.println("Erreur d'execution : " + req + " : " + exp);
    // }

    // }

    public static ArrayList<Note> getAllNotes() {
        String req = "select * from notes;";
        ArrayList<Note> lesNotes = new ArrayList<Note>();
        try {
            maConnexion.seConnecter();
            Statement unStat = maConnexion.getMaConnexion().createStatement();
            ResultSet desRes = unStat.executeQuery(req);
            while (desRes.next()) {
                Note uneNote = new Note(desRes.getInt("idNote"),
                        desRes.getString("titre"),
                        desRes.getString("description"), desRes.getInt("idCategorie"), desRes.getInt("isFavorite"));
                lesNotes.add(uneNote);
            }
            unStat.close();
            maConnexion.seDeconnecter();
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
        }
        return lesNotes;
    }

    // public static void deleteClient(int idclient) {
    // String req = "delete from client where idclient = " + idclient + ";";
    // try {
    // maConnexion.seConnecter();
    // Statement unStat = maConnexion.getMaConnexion().createStatement();
    // unStat.execute(req);
    // unStat.close();
    // maConnexion.seDeconnecter();
    // } catch (SQLException exp) {
    // System.out.println("Erreur d'execution : " + req + " : " + exp);
    // }
    // }

    // public static Client selectWhereClient(int idclient) {
    // String req = "select * from client where idclient = " + idclient + ";";
    // Client unClient = null;
    // try {
    // maConnexion.seConnecter();
    // Statement unStat = maConnexion.getMaConnexion().createStatement();
    // ResultSet unRes = unStat.executeQuery(req);
    // if (unRes.next()) {
    // unClient = new Client(
    // unRes.getInt("idclient"),
    // unRes.getString("nom"),
    // unRes.getString("prenom"),
    // unRes.getString("adresse"));
    // }
    // unStat.close();
    // maConnexion.seDeconnecter();
    // } catch (SQLException exp) {
    // System.out.println("Erreur d'execution : " + req + " : " + exp);
    // }

    // return unClient;
    // }

    // public static void updateClient(Client unClient) {
    // String req = "update client set "
    // + "nom = '" + unClient.getNom() + "',"
    // + "prenom = '" + unClient.getPrenom() + "',"
    // + "adresse = '" + unClient.getAdresse() + "' "
    // + "where idclient = " + unClient.getIdclient() + ";";
    // try {
    // maConnexion.seConnecter();
    // Statement unStat = maConnexion.getMaConnexion().createStatement();
    // unStat.execute(req);
    // unStat.close();
    // maConnexion.seDeconnecter();
    // } catch (SQLException exp) {
    // System.out.println("Erreur d'execution : " + req + " : " + exp);
    // }
    // }

    // public static ArrayList<Client> selectLikeClients(String filtre) {
    // String req = "select * from client where "
    // + "nom like '%" + filtre + "%' "
    // + "or prenom like '%" + filtre + "%' "
    // + "or adresse like '%" + filtre + "%';";
    // ArrayList<Client> lesClients = new ArrayList<Client>();
    // try {
    // maConnexion.seConnecter();
    // Statement unStat = maConnexion.getMaConnexion().createStatement();
    // ResultSet desRes = unStat.executeQuery(req);
    // while (desRes.next()) {
    // Client unClient = new Client(desRes.getInt("idclient"),
    // desRes.getString("nom"),
    // desRes.getString("prenom"), desRes.getString("adresse"));
    // lesClients.add(unClient);
    // }
    // unStat.close();
    // maConnexion.seDeconnecter();
    // } catch (SQLException exp) {
    // System.out.println("Erreur d'execution : " + req + " : " + exp);
    // }

    // return lesClients;
    // }
}
