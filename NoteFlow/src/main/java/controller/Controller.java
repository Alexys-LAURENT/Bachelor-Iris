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
}
