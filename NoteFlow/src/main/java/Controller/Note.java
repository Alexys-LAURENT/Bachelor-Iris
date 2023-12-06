package Controller;

public class Note {
    private int idNote;
    private String title, content, category, isFavorite;

    public Note() {
        super();
        this.idNote = 0;
        this.title = "";
        this.content = "";
        this.category = "";
        this.isFavorite = "";
    }

    public Note(int idNote, String title, String content, String category, String isFavorite) {
        super();
        this.idNote = idNote;
        this.title = title;
        this.content = content;
        this.category = category;
        this.isFavorite = isFavorite;
    }

    public Note(String title, String content, String category, String isFavorite) {
        super();
        this.idNote = 0;
        this.title = title;
        this.content = content;
        this.category = category;
        this.isFavorite = isFavorite;
    }

    public int getIdNote() {
        return this.idNote;
    }

    public void setIdNote(int idNote) {
        this.idNote = idNote;
    }

    public String getTitle() {
        return this.title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return this.content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCategory() {
        return this.category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getIsFavorite() {
        return this.isFavorite;
    }

    public void setIsFavorite(String isFavorite) {
        this.isFavorite = isFavorite;
    }

}
