package controller;

public class Categorie {
	 private int idcategorie, iduser;
	    private String libelle, hex;

	    public Categorie() {
	        super();
	        this.idcategorie = 0;
	        this.iduser = 0;
	        this.libelle = "";
	        this.hex = "";
	        
	    }

	    public Categorie(int idcategorie, int iduser, String libelle, String hex) {
	        super();
	        this.idcategorie = idcategorie;
	        this.iduser = iduser;
	        this.libelle = libelle;
	        this.hex = hex;
	      
	    }

	    public Categorie( int iduser, String libelle, String hex) {
	        super();
	        this.idcategorie = 0;
	        this.iduser = iduser;
	        this.libelle = libelle;
	        this.hex = hex;
	      
	    }

		public int getIdcategorie() {
			return idcategorie;
		}

		public void setIdcategorie(int idcategorie) {
			this.idcategorie = idcategorie;
		}

		public int getIduser() {
			return iduser;
		}

		public void setIduser(int iduser) {
			this.iduser = iduser;
		}

		public String getLibelle() {
			return libelle;
		}

		public void setLibelle(String libelle) {
			this.libelle = libelle;
		}

		public String getHex() {
			return hex;
		}

		public void setHex(String hex) {
			this.hex = hex;
		}

	    

}
