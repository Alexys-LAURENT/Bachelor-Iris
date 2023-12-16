package controller;

import java.util.ArrayList;

import Model.Model;

public class Controller {
    public static ArrayList<ExtendedNote> getAllNotes() {
        return Model.getAllNotes();
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

    public static User checkToken(String token) {
        return Model.checkToken(token);
    }

    public static boolean toggleThemeMode(String themeMode, int idUser) {
        return Model.toggleThemeMode(themeMode, idUser);
    }
}
