package controller;

import java.util.ArrayList;

import model.Model;

public class Controller {
    public static ArrayList<ExtendedNote> getAllNotes() {
        return Model.getAllNotes();
    }
}
