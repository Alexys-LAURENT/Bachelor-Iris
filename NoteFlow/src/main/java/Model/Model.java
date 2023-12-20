package Model;

import java.util.ArrayList;

import controller.ExtendedNote;
import controller.User;
import controller.Tag;
import controller.Share;

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

    public static ArrayList<User> getCollegues(int idUser) {
        String req = "SELECT * FROM users WHERE idUser != ? and idEntreprise = (SELECT idEntreprise FROM users WHERE idUser = ?);";
        ArrayList<User> lesUsers = new ArrayList<User>();
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setInt(1, idUser);
            unStat.setInt(2, idUser);
            ResultSet desRes = unStat.executeQuery();
            while (desRes.next()) {
                User unUser = new User(desRes.getInt("idUser"), desRes.getString("nom"),
                        desRes.getString("prenom"), desRes.getString("metier"), desRes.getString("pp"),
                        desRes.getString("email"), desRes.getString("theme"), desRes.getString("statut"));
                lesUsers.add(unUser);
            }
            unStat.close();
            maConnexion.seDeconnecter();
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
        }
        return lesUsers;
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

    public static ExtendedNote getNoteById(int idNote, int idUser) {
        String req = "SELECT n.*, COALESCE(c.libelle, '') AS libelle, COALESCE(c.hex, '') AS hex "
                + "FROM notes n "
                + "LEFT JOIN categories c ON n.idCategorie = c.idCategorie "
                + "WHERE n.idNote = ? AND n.idUser = ?";
        ExtendedNote uneNote = null;
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setInt(1, idNote);
            unStat.setInt(2, idUser);
            ResultSet desRes = unStat.executeQuery();
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
        String req = "UPDATE notes SET content = ?, timestamp=CURRENT_TIMESTAMP() WHERE idNote = ?";
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

    public static boolean editTag(int idTag, String tagName, String hex) {
        String req = "UPDATE categories SET libelle = ?, hex = ? WHERE idCategorie = ?";
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setString(1, tagName);
            unStat.setString(2, hex);
            unStat.setInt(3, idTag);
            unStat.executeUpdate();
            unStat.close();
            maConnexion.seDeconnecter();
            return true;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return false;
        }
    }

    public static boolean deleteTag(int idTag) {
        String req1 = "UPDATE notes SET idCategorie = null WHERE idCategorie = ?;";
        String req2 = "DELETE FROM categories WHERE idCategorie = ?;";
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat1 = maConnexion.getMaConnexion().prepareStatement(req1);
            unStat1.setInt(1, idTag);
            unStat1.executeUpdate();
            unStat1.close();
            PreparedStatement unStat2 = maConnexion.getMaConnexion().prepareStatement(req2);
            unStat2.setInt(1, idTag);
            unStat2.executeUpdate();
            unStat2.close();
            maConnexion.seDeconnecter();
            return true;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req1 + " : " + exp);
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

    public static ArrayList<Share> getShares(int idNote) {
        String req = "SELECT s.*, u.nom, u.prenom, u.pp FROM sharednotes s INNER JOIN users u ON s.idShared = u.idUser WHERE s.idNote = ?";
        ArrayList<Share> shares = new ArrayList<Share>();
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setInt(1, idNote);
            ResultSet desRes = unStat.executeQuery();
            while (desRes.next()) {
                Share share = new Share(
                        desRes.getInt("idShare"),
                        desRes.getInt("idNote"),
                        desRes.getInt("idOwner"),
                        desRes.getInt("idShared"),
                        desRes.getString("prenom"),
                        desRes.getString("nom"),
                        desRes.getString("pp"),
                        desRes.getString("permissions"));
                shares.add(share);
            }
            unStat.close();
            maConnexion.seDeconnecter();
            return shares;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return shares;
        }
    }

    public static boolean deleteShare(int idShare, int idUser) {
        String req = "DELETE FROM sharednotes WHERE idShare = ? AND idOwner = ?";
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setInt(1, idShare);
            unStat.setInt(2, idUser);
            unStat.executeUpdate();
            unStat.close();
            maConnexion.seDeconnecter();
            return true;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return false;
        }

    }

    public static boolean shareNoteWithUser(int idNote, int idOwner, int idShared, String permissions) {
        try {
            maConnexion.seConnecter();

            // Check if share already exists
            String checkReq = "SELECT * FROM sharednotes WHERE idNote = ? AND idOwner = ? AND idShared = ?";
            PreparedStatement checkStat = maConnexion.getMaConnexion().prepareStatement(checkReq);
            checkStat.setInt(1, idNote);
            checkStat.setInt(2, idOwner);
            checkStat.setInt(3, idShared);
            ResultSet rs = checkStat.executeQuery();

            if (rs.next()) {
                // If share exists, update permissions
                String updateReq = "UPDATE sharednotes SET permissions = ? WHERE idNote = ? AND idOwner = ? AND idShared = ?";
                PreparedStatement updateStat = maConnexion.getMaConnexion().prepareStatement(updateReq);
                updateStat.setString(1, permissions);
                updateStat.setInt(2, idNote);
                updateStat.setInt(3, idOwner);
                updateStat.setInt(4, idShared);
                updateStat.executeUpdate();
                updateStat.close();
            } else {
                // If share does not exist, insert new share
                String insertReq = "INSERT INTO sharednotes (idNote, idOwner, idShared, permissions) VALUES (?, ?, ?, ?)";
                PreparedStatement insertStat = maConnexion.getMaConnexion().prepareStatement(insertReq);
                insertStat.setInt(1, idNote);
                insertStat.setInt(2, idOwner);
                insertStat.setInt(3, idShared);
                insertStat.setString(4, permissions);
                insertStat.executeUpdate();
                insertStat.close();
            }

            maConnexion.seDeconnecter();
            return true;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + exp);
            return false;
        }
    }

    public static ArrayList<ExtendedNote> returnSharedNotes(int idUser) {
        String req = "SELECT n.*, COALESCE(c.libelle, '') AS libelle, COALESCE(c.hex, '') AS hex\r\n"
                + "FROM notes n\r\n"
                + "LEFT JOIN categories c ON n.idCategorie = c.idCategorie\r\n"
                + "WHERE n.idNote IN (SELECT idNote FROM sharednotes WHERE idShared = ?) LIMIT 100";
        ArrayList<ExtendedNote> lesNotes = new ArrayList<ExtendedNote>();
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setInt(1, idUser);
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
            return lesNotes;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return lesNotes;
        }
    }

    public static ExtendedNote getNoteSharedById(int idNote, int idUser) {
        String req = "SELECT n.*, COALESCE(c.libelle, '') AS libelle, COALESCE(c.hex, '') AS hex "
                + "FROM notes n "
                + "LEFT JOIN categories c ON n.idCategorie = c.idCategorie "
                + "WHERE n.idNote = ? AND n.idNote IN (SELECT idNote FROM sharednotes WHERE idShared = ?)";
        ExtendedNote uneNote = null;
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setInt(1, idNote);
            unStat.setInt(2, idUser);
            ResultSet desRes = unStat.executeQuery();
            if (desRes.next()) {
                uneNote = new ExtendedNote(desRes.getInt("idNote"),
                        desRes.getString("titre"),
                        desRes.getString("content"), desRes.getInt("idCategorie"), desRes.getInt("isFavorite"),
                        desRes.getString("libelle"), desRes.getString("hex"), desRes.getTimestamp("timestamp"));
            }
            unStat.close();
            maConnexion.seDeconnecter();
            return uneNote;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return uneNote;
        }
    }

    public static String getPermission(int idNote, int idUser) {
        String req = "SELECT permissions FROM sharednotes WHERE idNote = ? AND idShared = ?";
        String permissions = "";
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setInt(1, idNote);
            unStat.setInt(2, idUser);
            ResultSet desRes = unStat.executeQuery();
            if (desRes.next()) {
                permissions = desRes.getString("permissions");
            }
            unStat.close();
            maConnexion.seDeconnecter();
            return permissions;
        } catch (SQLException exp) {
            System.out.println("Erreur d'execution : " + req + " : " + exp);
            return permissions;
        }
    }

    public static boolean isShared(int idNote, int idUser) {
        String req = "SELECT * FROM sharednotes WHERE idNote = ? AND idShared != ?";
        try {
            maConnexion.seConnecter();
            PreparedStatement unStat = maConnexion.getMaConnexion().prepareStatement(req);
            unStat.setInt(1, idNote);
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
}
