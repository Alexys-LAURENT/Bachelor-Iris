package controller;

import java.util.ArrayList;

import model.Model;

public class Controller {
    public static ArrayList<Note> getAllNotes() {
        return Model.getAllNotes();
    }
}
