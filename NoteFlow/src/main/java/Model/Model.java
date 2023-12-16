package Model;

import java.util.ArrayList;

import controller.ExtendedNote;
import controller.User;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.sql.Timestamp;
import java.util.Date;

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

    public static User checkToken(String token) {
        String sql = "SELECT * FROM token WHERE token = ?;";
        try {
            maConnexion.seConnecter();
            PreparedStatement stmt = maConnexion.getMaConnexion().prepareStatement(sql);
            stmt.setString(1, token);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Timestamp tokenDate = rs.getTimestamp("expireAt");
                if (tokenDate.before(new Date())) {
                    maConnexion.seDeconnecter();
                    return null;
                } else {
                    sql = "SELECT idUser, nom, prenom, metier, pp, email, theme, statut FROM users WHERE idUser = (SELECT idUser FROM token WHERE token = ?);";
                    stmt = maConnexion.getMaConnexion().prepareStatement(sql);
                    stmt.setString(1, token);
                    ResultSet userSet = stmt.executeQuery();
                    if (userSet.next()) {
                        User user = new User(userSet.getInt("idUser"), userSet.getString("nom"),
                                userSet.getString("prenom"), userSet.getString("metier"), userSet.getString("pp"),
                                userSet.getString("email"), userSet.getString("theme"), userSet.getString("statut"));
                        maConnexion.seDeconnecter();
                        return user;
                    }
                }
            }
            maConnexion.seDeconnecter();
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + sql + " : " + exp);
        }
        return null;
    }

    public static boolean toggleThemeMode(String themeMode, int idUser) {
        String req = "update users set theme = '" + themeMode + "' where idUser = " + idUser + ";";
        try {
            maConnexion.seConnecter();
            Statement unStat = maConnexion.getMaConnexion().createStatement();
            unStat.execute(req);
            unStat.close();
            maConnexion.seDeconnecter();
            return true;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return false;
        }
    }

    public static ArrayList<ExtendedNote> getAllNotes() {
        String req = "select n.*, c.libelle, c.hex from notes n inner join categories c on n.idCategorie = c.idCategorie LIMIT 100;";
        ArrayList<ExtendedNote> lesNotes = new ArrayList<ExtendedNote>();
        try {
            maConnexion.seConnecter();
            Statement unStat = maConnexion.getMaConnexion().createStatement();
            ResultSet desRes = unStat.executeQuery(req);
            while (desRes.next()) {
                ExtendedNote uneNote = new ExtendedNote(desRes.getInt("idNote"),
                        desRes.getString("titre"),
                        desRes.getString("content"), desRes.getInt("idCategorie"), desRes.getInt("isFavorite"),
                        desRes.getString("libelle"), desRes.getString("hex"), desRes.getTimestamp("timestamp"));
                lesNotes.add(uneNote);
            }
            unStat.close();
            maConnexion.seDeconnecter();
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
        }
        return lesNotes;
    }

    public static ExtendedNote getNoteById(int idNote) {
        String req = "select n.*, c.libelle, c.hex from notes n inner join categories c on n.idCategorie = c.idCategorie where idNote = "
                + idNote + ";";
        ExtendedNote uneNote = null;
        try {
            maConnexion.seConnecter();
            Statement unStat = maConnexion.getMaConnexion().createStatement();
            ResultSet desRes = unStat.executeQuery(req);
            if (desRes.next()) {
                uneNote = new ExtendedNote(desRes.getInt("idNote"),
                        desRes.getString("titre"),
                        desRes.getString("content"), desRes.getInt("idCategorie"), desRes.getInt("isFavorite"),
                        desRes.getString("libelle"), desRes.getString("hex"), desRes.getTimestamp("timestamp"));
            }
            unStat.close();
            maConnexion.seDeconnecter();
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
        }
        return uneNote;
    }

    public static boolean toggleFavorite(int idNote) {
        String req = "update notes set isFavorite = !isFavorite where idNote = " + idNote + ";";
        try {
            maConnexion.seConnecter();
            Statement unStat = maConnexion.getMaConnexion().createStatement();
            unStat.execute(req);
            unStat.close();
            maConnexion.seDeconnecter();
            return true;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return false;
        }
    }

    public static boolean delete(int idNote) {
        String req = "delete from notes where idNote = " + idNote + ";";
        try {
            maConnexion.seConnecter();
            Statement unStat = maConnexion.getMaConnexion().createStatement();
            unStat.execute(req);
            unStat.close();
            maConnexion.seDeconnecter();
            return true;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return false;
        }
    }

    public static boolean updateNote(int idNote, String outputData) {
        String req = "update notes set content = '" + outputData + "' where idNote = " + idNote + ";";
        try {
            maConnexion.seConnecter();
            Statement unStat = maConnexion.getMaConnexion().createStatement();
            unStat.execute(req);
            unStat.close();
            maConnexion.seDeconnecter();
            return true;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return false;
        }
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
