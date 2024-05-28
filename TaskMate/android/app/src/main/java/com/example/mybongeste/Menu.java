package com.example.mybongeste;

import android.view.ViewGroup; // Assurez-vous d'importer ViewGroup depuis android.view
import android.view.LayoutInflater; // Importation correcte pour LayoutInflater

// Assurez-vous que toutes les importations nécessaires sont présentes
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.ListView;
import android.widget.TextView;
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
import java.util.ArrayList;

public class Menu extends AppCompatActivity {
    private Personne unePersonne;
    private ListView lvTodos;
    private static ArrayList<Todo> mesTodos = new ArrayList<Todo>();
    private TextView welcomeText, emptyText ;

    private Button createToDoBtn, logoutBtn;

    public static ArrayList<Todo> getMesTodos() {
        return mesTodos;
    }

    public static void setMesTodos(ArrayList<Todo> mesTodos) {
        Menu.mesTodos = mesTodos;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_menu);

        String stringyfiedUser = getIntent().getStringExtra("loggedUser");
        unePersonne = new Personne();
        if (stringyfiedUser != null) {
            unePersonne.construire(stringyfiedUser);
        } else {
            Intent unIntent = new Intent(this, MainActivity.class);
            this.startActivity(unIntent);
        }
        this.emptyText = findViewById(R.id.emptyText);
        this.welcomeText = findViewById(R.id.welcomeText);
        this.welcomeText.setText("Bienvenue " + unePersonne.getPrenom() + " " + unePersonne.getNom());

        this.lvTodos = findViewById(R.id.todosListView);
        this.createToDoBtn = findViewById(R.id.createToDoBtn);

        // Définir l'OnClickListener pour le bouton de création de Todo
        this.createToDoBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(Menu.this, TodoForm.class);
                intent.putExtra("action", "create");
                intent.putExtra("loggedUser", unePersonne.stringify());
                startActivity(intent);
            }
        });

        this.logoutBtn = findViewById(R.id.logoutButton);
        this.logoutBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(Menu.this, MainActivity.class);
                Toast.makeText(Menu.this, "Déconnexion réussie", Toast.LENGTH_LONG).show();
                startActivity(intent);
            }
        });

        // Lancement de la tâche asynchrone
        GetMesToDos uneTache = new GetMesToDos();
        uneTache.execute(unePersonne.getIdUser());
    }

    private void afficherTodos() {
        // Affichage des todos

        if(mesTodos.size() == 0){
            this.emptyText.setVisibility(View.VISIBLE);
        }else{
            this.emptyText.setVisibility(View.GONE);
        }
        TodoAdapter adapter = new TodoAdapter(this, mesTodos);
        lvTodos.setAdapter(adapter);

        // Définir l'OnItemClickListener
        this.lvTodos.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Todo selectedTodo = mesTodos.get(position);
                Intent intent = new Intent(Menu.this, TodoForm.class);
                intent.putExtra("selectedTodo", selectedTodo.stringify());
                intent.putExtra("action", "update");
                startActivity(intent);
            }
        });

    }

    // Tâche asynchrone
    class GetMesToDos extends AsyncTask<Integer, Void, ArrayList<Todo>> {

        @Override
        protected ArrayList<Todo> doInBackground(Integer... integers) {
            ArrayList<Todo> mesTodos = new ArrayList<>();
            int idUser = integers[0];
            String url = "http://192.168.1.16/android/taskmate/selectAllTodos?idUser=" + idUser;
            String resultat = "";

            try {
                // Connexion à l'URL
                URL uneURL = new URL(url);
                HttpURLConnection uneConnexion = (HttpURLConnection) uneURL.openConnection();
                // On fixe la méthode d'envoi des données
                uneConnexion.setRequestMethod("GET");
                uneConnexion.setConnectTimeout(12000);
                uneConnexion.connect();
                // Lecture des données
                InputStream in = uneConnexion.getInputStream();
                BufferedReader br = new BufferedReader(new InputStreamReader(in));
                StringBuilder sb = new StringBuilder();
                String ligne;
                // Tant qu'il y a des lignes à lire
                while ((ligne = br.readLine()) != null) {
                    sb.append(ligne);
                }
                resultat = sb.toString();
                Log.e("chaine lue : ", resultat);
                // Fermeture des flux
                in.close();
                uneConnexion.disconnect();
                Log.e("url", url);
            } catch (IOException exp) {
                Log.i("Erreur 1 : ", "Connexion à l'URL-> " + url);
            }
            try {
                // Parsing JSON
                JSONArray tabJson = new JSONArray(resultat);
                // Prendre le premier Objet JSON
                for (int i = 0; i < tabJson.length(); i++) {
                    JSONObject unObjet = tabJson.getJSONObject(i);
                    // On instancie la personne récupérée du JSON
                    Log.i("Todo : ", unObjet.getString("description"));
                    mesTodos.add(new Todo(unObjet.getInt("idToDo"), unObjet.getInt("idUser"), unObjet.getString("description"), unObjet.getString("timestamp"), unObjet.getString("etat")));
                }
            } catch (JSONException exp) {
                Log.e("Erreur 2 : ", "Impossible de parser la chaine lue");
                exp.printStackTrace();
            }
            return mesTodos;
        }

        @Override
        protected void onPostExecute(ArrayList<Todo> mesTodos) {
            super.onPostExecute(mesTodos);
            Menu.setMesTodos(mesTodos);
            afficherTodos(); // Appel de la méthode pour afficher les todos
        }
    }

    public class TodoAdapter extends ArrayAdapter<Todo> {
        private Context mContext;

        public TodoAdapter(Context context, ArrayList<Todo> todos) {
            super(context, 0, todos);
            mContext = context;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            Todo todo = getItem(position);
            if (convertView == null) {
                convertView = LayoutInflater.from(getContext()).inflate(R.layout.list_item_todo, parent, false);
            }

            TextView todoDescription = convertView.findViewById(R.id.todoDescription);
            TextView todoDate = convertView.findViewById(R.id.todoDate);
            CheckBox todoCheckbox = convertView.findViewById(R.id.todoCheckbox);

            // Mettre à jour les vues avec les données du Todo
            todoDescription.setText(todo.getDescription());
            todoDate.setText(todo.getTimestamp());

            // Gestionnaire d'événements pour la case à cocher
            todoCheckbox.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
                @Override
                public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                    if (isChecked) {
                        // Appel à la méthode pour valider le todo
                        validateTodo(todo.getIdTodo());
                    }
                }
            });

            // Gestionnaire d'événements pour l'élément de la liste (sauf la case à cocher)
            convertView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    // Rediriger vers TodoForm si la case à cocher n'est pas cliquée
                    Intent intent = new Intent(mContext, TodoForm.class);
                    intent.putExtra("action", "update");
                    intent.putExtra("selectedTodo", todo.stringify());
                    intent.putExtra("loggedUser", unePersonne.stringify());
                    mContext.startActivity(intent);
                }
            });

            // Empêcher le clic sur la case à cocher de déclencher le clic sur l'élément de la liste
            todoCheckbox.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    // Ne rien faire ici
                }
            });

            return convertView;
        }
    }

    // Méthode pour valider le todo
    private void validateTodo(int todoId) {
        // Construction de l'URL pour l'appel API
        String apiUrl = "http://192.168.1.16/android/taskmate/validateTodo?idTodo=" + todoId;

        // Lancement de la tâche asynchrone pour effectuer l'appel API
        ValidateTodoTask task = new ValidateTodoTask();
        task.execute(apiUrl);
    }

    // Tâche asynchrone pour effectuer l'appel API
    private class ValidateTodoTask extends AsyncTask<String, Void, Void> {
        @Override
        protected Void doInBackground(String... urls) {
            try {
                String apiUrl = urls[0];
                URL url = new URL(apiUrl);
                HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
                try {
                    InputStream in = urlConnection.getInputStream();
                    // Lecture de la réponse de l'API (si nécessaire)
                } finally {
                    urlConnection.disconnect();
                }
            } catch (IOException e) {
                Log.e("Error", "Error while validating todo: " + e.getMessage());
            }
            return null;
        }

        @Override
        protected void onPostExecute(Void result) {
            // Actualisation de la page après avoir validé le todo
            refreshPage();
        }
    }

    // Méthode pour actualiser la page
    private void refreshPage() {
        // Lancement de la tâche asynchrone pour récupérer à nouveau les todos
        GetMesToDos task = new GetMesToDos();
        task.execute(unePersonne.getIdUser());
    }
}
