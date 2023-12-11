package Controllera;

public class Categorie {
    private int idCategory;
    private String name, color;

    public Categorie() {
        super();
        this.idCategory = 0;
        this.name = "";
        this.color = "";
    }

    public Categorie(int idCategory, String name, String color) {
        super();
        this.idCategory = idCategory;
        this.name = name;
        this.color = color;
    }

    public Categorie(String name, String color) {
        super();
        this.idCategory = 0;
        this.name = name;
        this.color = color;
    }

    public int getIdCategory() {
        return this.idCategory;
    }

    public void setIdCategory(int idCategory) {
        this.idCategory = idCategory;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getColor() {
        return this.color;
    }

    public void setColor(String color) {
        this.color = color;
    }
}