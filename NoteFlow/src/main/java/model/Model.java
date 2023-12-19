package Model;

import java.util.ArrayList;

import controller.ExtendedNote;
import controller.User;
import controller.Tag;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.sql.Timestamp;
import java.util.Date;

public class Model {
    private static Connexion maConnexion = new Connexion("localhost:3306",
            "syncpro", "root", "");


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

    public static ArrayList<ExtendedNote> getAllNotes(String categorie, int idUser) {
        String req = "";
        ArrayList<ExtendedNote> lesNotes = new ArrayList<ExtendedNote>();

        if ("null".equals(categorie) || "".equals(categorie)) {
            req = "SELECT n.*, COALESCE(c.libelle, '') AS libelle, COALESCE(c.hex, '') AS hex\r\n"
            		+ "FROM notes n\r\n"
            		+ "LEFT JOIN categories c ON n.idCategorie = c.idCategorie\r\n"
            		+ "WHERE n.idUser = ? LIMIT 100";
        } else {
            // check if categorie is a categorie from user
            if (!checkIfTagIsFromUser(categorie, idUser)) {
                req = "SELECT n.*, COALESCE(c.libelle, '') AS libelle, COALESCE(c.hex, '') AS hex\r\n"
                		+ "FROM notes n\r\n"
                		+ "LEFT JOIN categories c ON n.idCategorie = c.idCategorie\r\n"
                		+ "WHERE n.idUser = ? LIMIT 100";
            } else {
                req = "select n.*, c.libelle, c.hex from notes n inner join categories c on n.idCategorie = c.idCategorie where c.idCategorie = ? AND n.idUser = ?";
            }
        }
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            if ("null".equals(categorie) || "".equals(categorie) || !checkIfTagIsFromUser(categorie, idUser)) {
                unStat.setInt(1, idUser);
            } else {
                unStat.setString(1, categorie);
                unStat.setInt(2, idUser);
            }
            ResultSet desRes = unStat.executeQuery();
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

    public static boolean checkIfTagIsFromUser(String categorie, int idUser) {
        String req = "SELECT * FROM categories WHERE idCategorie = ? AND idUser = ?;";
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setString(1, categorie);
            unStat.setInt(2, idUser);
            ResultSet desRes = unStat.executeQuery();
            if (desRes.next()) {
                unStat.close();
                maConnexion.seDeconnecter();
                return true;
            }
            unStat.close();
            maConnexion.seDeconnecter();
            return false;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return false;
        }
    }

    public static ExtendedNote getNoteById(int idNote) {
        String req = "SELECT n.*, COALESCE(c.libelle, '') AS libelle, COALESCE(c.hex, '') AS hex\r\n"
        		+ "FROM notes n\r\n"
        		+ "LEFT JOIN categories c ON n.idCategorie = c.idCategorie\r\n"
        		+ "WHERE n.idNote = "+ idNote +" LIMIT 100";
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

    public static boolean renameNote(String titre, int idNote) {
        String req = "update notes set titre = ? where idNote = ?;";
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setString(1, titre);
            unStat.setInt(2, idNote);
            unStat.executeUpdate();
            unStat.close();
            maConnexion.seDeconnecter();
            return true;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return false;
        }
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
        String req = "UPDATE notes SET content = ? WHERE idNote = ?";
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setString(1, outputData);
            unStat.setInt(2, idNote);
            unStat.executeUpdate();
            unStat.close();
            maConnexion.seDeconnecter();
            return true;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return false;
        }
    }

    public static String getNoteContent(int idNote) {
        String req = "SELECT content FROM notes WHERE idNote = ?";
        String content = "";
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setInt(1, idNote);
            ResultSet desRes = unStat.executeQuery();
            if (desRes.next()) {
                content = desRes.getString("content");
            }
            unStat.close();
            maConnexion.seDeconnecter();
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
        }
        return content;
    }

    public static ArrayList<Tag> getUserTags(int idUser) {
        String req = "SELECT * FROM categories WHERE idUser = ?";
        ArrayList<Tag> tags = new ArrayList<Tag>();
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setInt(1, idUser);
            ResultSet desRes = unStat.executeQuery();
            while (desRes.next()) {
                Tag tag = new Tag(desRes.getInt("idCategorie"), desRes.getString("libelle"),
                        desRes.getString("hex"));
                tags.add(tag);
            }
            unStat.close();
            maConnexion.seDeconnecter();
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
        }
        return tags;
    }

    public static boolean updateNoteTag(int idNote, int idTag) {
        String req = "UPDATE notes SET idCategorie = ? WHERE idNote = ?";
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setInt(1, idTag);
            unStat.setInt(2, idNote);
            // Log the prepared statement
            unStat.executeUpdate();
            unStat.close();
            maConnexion.seDeconnecter();
            return true;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return false;
        }
    }

    public static boolean createTagInNote(int idUser, String tagName, String hex, int idNote) {
        String req = "INSERT INTO categories (libelle, hex, idUser) VALUES (?, ?, ?)";
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setString(1, tagName);
            unStat.setString(2, hex);
            unStat.setInt(3, idUser);
            unStat.executeUpdate();
            unStat.close();
            maConnexion.seDeconnecter();
            return updateNoteTag(idNote, lastInsertIdTag(idUser));
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return false;
        }
    }

    public static int lastInsertIdTag(int idUser) {
        String req = "SELECT idCategorie FROM categories WHERE idUser = ? ORDER BY idCategorie DESC LIMIT 1";
        int idTag = 0;
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setInt(1, idUser);
            ResultSet desRes = unStat.executeQuery();
            if (desRes.next()) {
                idTag = desRes.getInt("idCategorie");
            }
            unStat.close();
            maConnexion.seDeconnecter();
            return idTag;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return idTag;
        }
    }

    public static boolean createTagOutsideNote(int idUser, String tagName, String hex) {
        String req = "INSERT INTO categories (libelle, hex, idUser) VALUES (?, ?, ?)";
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setString(1, tagName);
            unStat.setString(2, hex);
            unStat.setInt(3, idUser);
            unStat.executeUpdate();
            unStat.close();
            maConnexion.seDeconnecter();
            return true;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return false;
        }
    }

    public static boolean createNote(String titre, String idCategory, int idUser) {
        String req = "";
        if ("0".equals(idCategory)) {
            req = "INSERT INTO notes (titre, idCategorie, idUser, content) VALUES (?, null, ?, '')";
        } else {
            req = "INSERT INTO notes (titre, idCategorie, idUser, content) VALUES (?, ?, ?, '')";
        }
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            if ("0".equals(idCategory)) {
                unStat.setString(1, titre);
                unStat.setInt(2, idUser);
            } else {
                unStat.setString(1, titre);
                unStat.setString(2, idCategory);
                unStat.setInt(3, idUser);
            }
            unStat.executeUpdate();
            unStat.close();
            maConnexion.seDeconnecter();
            return true;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return false;
        }
    }

}
