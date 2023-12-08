package Controllera;

import java.util.ArrayList;

import Model.Modele;

public class Controlleur {
    public static ArrayList<Note> getAllNotes() {
        return Modele.getAllNotes();
    }
}
