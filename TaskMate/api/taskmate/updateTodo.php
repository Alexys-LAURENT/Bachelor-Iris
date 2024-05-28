<?php
require_once("../controleur/controleur.class.php");

$filename = "../log.txt";
$description = isset($_REQUEST['description']) ? $_REQUEST['description'] : 'not set';
$timestamp = isset($_REQUEST['timestamp']) ? $_REQUEST['timestamp'] : 'not set';
$idTodo = isset($_REQUEST['idTodo']) ? $_REQUEST['idTodo'] : 'not set';
$dateTime = DateTime::createFromFormat('d/m/Y', $timestamp);
$mysqlDate = $dateTime ? $dateTime->format('Y-m-d') : $timestamp;

// Format des données à écrire
$data = "/////////UPDATE TODO/////////////// \n " . date('Y-m-d H:i:s') . " \n Request : \n Description: $description\nOriginal imestamp: $timestamp\nFormated timestamp: $mysqlDate\nIdTodo: $idTodo\n";


// Écriture dans le fichier
file_put_contents($filename, $data, FILE_APPEND);
if (isset($_REQUEST['description']) && isset($mysqlDate) && isset($_REQUEST['idTodo'])) {
    // Création de la tâche
    $tab = array(
        "description" => $_REQUEST['description'],
        "timestamp" => $mysqlDate,
        "idTodo" => $_REQUEST['idTodo']
    );
    Controleur::updateTodo($tab);

    // Réponse JSON pour indiquer le succès
    echo '{"success":true}';
} else {
    // Si l'une des données n'est pas définie, renvoyer une réponse vide
    echo '[]';
}
?>
