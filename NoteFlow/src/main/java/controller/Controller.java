package controller;

import java.util.ArrayList;

import Model.Model;

public class Controller {
    // getAllNotes can take a optional parameter to filter the notes
    public static ArrayList<ExtendedNote> getAllNotes(String filter, int idUser) {
        return Model.getAllNotes(filter, idUser);
    }

    public static ArrayList<ExtendedNote> returnFavNotes(ArrayList<ExtendedNote> notes) {
        ArrayList<ExtendedNote> favNotes = new ArrayList<ExtendedNote>();
        for (ExtendedNote note : notes) {
            if (note.getIsFavorite() == 1) {
                favNotes.add(note);
            }
        }
        return favNotes;
    }

    public static boolean renameNote(String titre, int idNote) {
        return Model.renameNote(titre, idNote);
    }

    public static boolean toggleFavorite(int idNote) {
        return Model.toggleFavorite(idNote);
    }

    public static boolean delete(int idNote) {
        return Model.delete(idNote);
    }

    public static boolean updateNote(int idNote, String outputData) {
        return Model.updateNote(idNote, outputData);
    }

    public static String getNoteContent(int idNote) {
        return Model.getNoteContent(idNote);
    }

    public static User checkToken(String token) {
        return Model.checkToken(token);
    }

    public static boolean toggleThemeMode(String themeMode, int idUser) {
        return Model.toggleThemeMode(themeMode, idUser);
    }

    public static ExtendedNote getNoteById(int idNote) {
        return Model.getNoteById(idNote);
    }

    public static ArrayList<Tag> getUserTags(int idUser) {
        return Model.getUserTags(idUser);
    }

    public static boolean updateNoteTag(int idNote, int idTag) {
        return Model.updateNoteTag(idNote, idTag);
    }

    public static boolean createTagInNote(int idUser, String tagName, String hex, int idNote) {
        System.out.println("Controller: " + idUser + " " + tagName + " " + hex + " " + idNote);
        return Model.createTagInNote(idUser, tagName, hex, idNote);
    }

    public static boolean createTagOutsideNote(int idUser, String tagName, String hex) {
        return Model.createTagOutsideNote(idUser, tagName, hex);
    }

    public static boolean createNote(String titre, String idCategory, int idUser) {
        return Model.createNote(titre, idCategory, idUser);
    }
}
