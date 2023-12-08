package Controllera;

public class Note {
    private int idNote, isFavorite, idCategorie;
    private String titre, content;

    public Note() {
        super();
        this.idNote = 0;
        this.titre = "";
        this.content = "";
        this.idCategorie = 0;
        this.isFavorite = 0;
    }

    public Note(int idNote, String titre, String content, int idCategorie, int isFavorite) {
        super();
        this.idNote = idNote;
        this.titre = titre;
        this.content = content;
        this.idCategorie = idCategorie;
        this.isFavorite = isFavorite;
    }

    public Note(String titre, String content, int idCategorie, int isFavorite) {
        super();
        this.idNote = 0;
        this.titre = titre;
        this.content = content;
        this.idCategorie = idCategorie;
        this.isFavorite = isFavorite;
    }

    public int getIdNote() {
        return this.idNote;
    }

    public void setIdNote(int idNote) {
        this.idNote = idNote;
    }

    public String getTitle() {
        return this.titre;
    }

    public void setTitle(String titre) {
        this.titre = titre;
    }

    public String getContent() {
        return this.content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getCategory() {
        return this.idCategorie;
    }

    public void setCategory(int idCategorie) {
        this.idCategorie = idCategorie;
    }

    public int getIsFavorite() {
        return this.isFavorite;
    }

    public void setIsFavorite(int isFavorite) {
        this.isFavorite = isFavorite;
    }

}
