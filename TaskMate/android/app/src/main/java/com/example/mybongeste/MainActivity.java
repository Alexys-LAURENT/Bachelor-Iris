package com.example.mybongeste;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {
    private EditText txtEmail, txtMdp;
    private Button btConnexion ;
    private static Personne unePersonneConnectee = null;

    public static Personne getUnePersonneConnectee() {
        return unePersonneConnectee;
    }

    public static void setUnePersonneConnectee(Personne unePersonneConnectee) {
        MainActivity.unePersonneConnectee = unePersonneConnectee;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        //correspondance entre les objets graphiques et les objets de prog.
        this.txtEmail=(EditText) findViewById(R.id.idEmail);
        this.txtMdp=(EditText) findViewById(R.id.idMdp);
        this.btConnexion=(Button) findViewById(R.id.idConnexion);

        //rendre le bouton ecoutable
        this.btConnexion.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        if(v.getId() == R.id.idConnexion){
            //récupération des email et mdp
            String email = this.txtEmail.getText().toString();
            String mdp = this.txtMdp.getText().toString();
            //instancie la classe Personne
            Personne unePersonne = new Personne(email, mdp);

            //vérification dans la BDD via un webservice
            VerifCon uneTache = new VerifCon();
            uneTache.execute (unePersonne);
            if (unePersonneConnectee == null){
                Toast.makeText(this,"Veuillez vérifier vos identifiants", Toast.LENGTH_LONG).show();
            }else {
                Toast.makeText(this,"Bienvenue à "+unePersonneConnectee.getNom(), Toast.LENGTH_LONG).show();
                //si Résultat positif : ouvrir la page Menu
                Intent unIntent = new Intent(this, Menu.class);
                unIntent.putExtra("loggedUser", unePersonneConnectee.stringify());
                this.startActivity(unIntent);
            }
        }
    }
}
//tache asynchrone
class VerifCon extends AsyncTask<Personne,Void,Personne>{

    @Override
    protected Personne doInBackground(Personne... personnes) {

        String url ="http://192.168.1.16/android/taskmate/verifConnexion.php";
        String email = personnes[0].getEmail();
        String mdp = personnes[0].getHashedPass();
        String resultat="";
        Personne personneBDD = null;

        try {
            url += "?email=" + URLEncoder.encode(email, "UTF-8");
            url += "&mdp=" + URLEncoder.encode(mdp, "UTF-8");
            URL uneURL = new URL(url);
            HttpURLConnection uneConnexion = (HttpURLConnection) uneURL.openConnection();
            //on fixe la méthode d'envoi des données
            uneConnexion.setRequestMethod("GET");
            uneConnexion.setConnectTimeout(12000);
            uneConnexion.connect();
            //lecture des données
            //page à lire
            InputStream in = uneConnexion.getInputStream();
            //buffer de lecture de la page
            BufferedReader br = new BufferedReader(new InputStreamReader(in));
            //définir une chaine evolutive
            StringBuilder sb = new StringBuilder();
            String ligne = "";
            //tant qu'il ya des lignes à lire
            while ((ligne = br.readLine())!= null){
                sb.append(ligne);
            }
            resultat = sb.toString();
            Log.e ("chaine lue : " , resultat);
            //fermeture des flux
            in.close();
            uneConnexion.disconnect();
        }
        catch (IOException exp)
        {
            Log.e("Erreur 1 : ", "Connexion à l'URL-> "+url);
        }
        try{
            //parsing JSON
            JSONArray tabJson = new JSONArray(resultat);
            //prendre le premier Objet JSON
            JSONObject unObjet = tabJson.getJSONObject(0); //le premier
            //on instancie la personne récupérée du JSON
            personneBDD = new Personne(unObjet.getInt("idUser"), unObjet.getInt("idEntreprise"), unObjet.getString("nom"), unObjet.getString("prenom"), unObjet.getString("email"), unObjet.getString("pp"));
        }
        catch (JSONException exp){
            Log.e("Erreur 2 : ", "Impossible de parser la chaine lue");
            exp.printStackTrace();
        }
        return personneBDD;
    }

    @Override
    protected void onPostExecute(Personne personne) {
        super.onPostExecute(personne);
        MainActivity.setUnePersonneConnectee(personne);
    }
}








