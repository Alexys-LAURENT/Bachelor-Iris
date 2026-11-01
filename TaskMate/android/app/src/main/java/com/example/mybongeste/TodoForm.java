package com.example.mybongeste;

import android.app.DatePickerDialog;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Calendar;

public class TodoForm extends AppCompatActivity {

    private Button dateButton, saveButton, cancelButton, deleteButton;
    private TextView actionText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_todo_form);

        actionText = findViewById(R.id.actionText);
        dateButton = findViewById(R.id.dateButton);
        saveButton = findViewById(R.id.saveButton);
        cancelButton = findViewById(R.id.cancelButton);
        deleteButton = findViewById(R.id.deleteButton);

        // Set the action text based on intent extra
        String action = getIntent().getStringExtra("action");
        if ("update".equals(action)) {
            actionText.setText("Modification de la todo");
        } else {
            actionText.setText("Création d'une todo");
            deleteButton.setVisibility(View.GONE);
        }

        // Configurez l'OnClickListener pour le bouton Annuler
        cancelButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // Terminez l'activité actuelle et revenez en arrière
                finish();
            }
        });

        // Fill fields if a todo is selected
        String selectedTodo = getIntent().getStringExtra("selectedTodo");
        if (selectedTodo != null) {
            Todo uneTodo = new Todo();
            uneTodo.construire(selectedTodo);

            EditText descriptionInput = findViewById(R.id.descriptionInput);
            descriptionInput.setText(uneTodo.getDescription());

            dateButton.setText(uneTodo.getTimestamp());

        }

        dateButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showDatePickerDialog();
            }
        });

        // Configurez l'OnClickListener pour le bouton Valider
        saveButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if ("create".equals(action)) {
                    createTodo();
                } else {
                    updateTodo();
                }
            }
        });

        // Configurez l'OnClickListener pour le bouton Supprimer
        deleteButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                deleteTodo();
            }
        });
    }

    private void showDatePickerDialog() {
        final Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);
        int day = calendar.get(Calendar.DAY_OF_MONTH);

        DatePickerDialog datePickerDialog = new DatePickerDialog(TodoForm.this, new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker view, int selectedYear, int selectedMonth, int selectedDay) {
                String date = selectedDay + "/" + (selectedMonth + 1) + "/" + selectedYear;
                dateButton.setText(date);
            }
        }, year, month, day);
        datePickerDialog.show();
    }


    private void deleteTodo() {
        String selectedTodo = getIntent().getStringExtra("selectedTodo");
        Todo todoToDelete = new Todo();
        todoToDelete.construire(selectedTodo);
        int idTodo = todoToDelete.getIdTodo();

        String url = "http://192.168.1.16/android/taskmate/deleteTodo?idTodo=" + idTodo;

        TodoOperationTask task = new TodoOperationTask();
        task.execute(url);
    }

    private void updateTodo() {
        EditText descriptionInput = findViewById(R.id.descriptionInput);
        String description = descriptionInput.getText().toString();
        String timestamp = dateButton.getText().toString();

        // Vérifier si la description et la date sont renseignées
        if (description.isEmpty() || timestamp.isEmpty() || timestamp.equals("Sélectionner une date")) {
            Toast.makeText(TodoForm.this, "Veuillez remplir tous les champs", Toast.LENGTH_SHORT).show();
            return;
        }

        // Récupérer l'ID de la todo à mettre à jour
        String selectedTodo = getIntent().getStringExtra("selectedTodo");
        Todo todoToUpdate = new Todo();
        todoToUpdate.construire(selectedTodo);
        int idTodo = todoToUpdate.getIdTodo();

        // Construire la requête URL pour l'appel API
        String url = "http://192.168.1.16/android/taskmate/updateTodo?idTodo=" + idTodo +
                "&description=" + URLEncoder.encode(description) + "&timestamp=" + URLEncoder.encode(timestamp);

        // Exécuter la tâche asynchrone pour mettre à jour la todo
        TodoOperationTask task = new TodoOperationTask();
        task.execute(url);
    }

    private void createTodo() {
        EditText descriptionInput = findViewById(R.id.descriptionInput);
        String description = descriptionInput.getText().toString();
        String timestamp = dateButton.getText().toString();

        // Vérifier si la description et la date sont renseignées
        if (description.isEmpty() || timestamp.isEmpty() || timestamp.equals("Sélectionner une date")) {
            Toast.makeText(TodoForm.this, "Veuillez remplir tous les champs", Toast.LENGTH_SHORT).show();
            return;
        }

        // Construire la requête URL pour l'appel API
        String loggedUserString = getIntent().getStringExtra("loggedUser");
        Personne loggedUser = new Personne();
        loggedUser.construire(loggedUserString);
        String url = "http://192.168.1.16/android/taskmate/createTodo?description=" + URLEncoder.encode(description) +
                "&timestamp=" + URLEncoder.encode(timestamp) + "&idUser=" + loggedUser.getIdUser();



        // Exécuter la tâche asynchrone pour créer la todo
        TodoOperationTask task = new TodoOperationTask();
        task.execute(url);
    }

    public class TodoOperationTask extends AsyncTask<String, Void, Void> {

        @Override
        protected Void doInBackground(String... urls) {
            try {
                String apiUrl = urls[0];
                URL url = new URL(apiUrl);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.connect();

                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = in.readLine()) != null) {
                    sb.append(line);
                }
                in.close();

                conn.disconnect();
            } catch (IOException e) {
                Log.e("Error", "Error while performing todo operation: " + e.getMessage());
            }
            return null;
        }

        @Override
        protected void onPostExecute(Void result) {
            // Affichage du toast après la création de la todo


            Toast.makeText(TodoForm.this, "Action effetcuée avec succès", Toast.LENGTH_SHORT).show();

            // Redirection vers la page Menu
            Intent intent = new Intent(TodoForm.this, Menu.class);
            intent.putExtra("loggedUser", getIntent().getStringExtra("loggedUser"));
            startActivity(intent);
        }
    }
}
