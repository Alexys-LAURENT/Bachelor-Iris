package controller;

import java.util.ArrayList;

import Model.Model;

public class Controller {
    // getAllNotes can take a optional parameter to filter the notes
    public static ArrayList<ExtendedNote> getAllNotes(String filter, int idUser){
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
}
