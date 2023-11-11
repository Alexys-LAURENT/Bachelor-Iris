<?php
require_once("Controller/config_bdd.php");
require_once("Controller/controller.class.php");

$unControleur = new Controleur($serveur, $bdd, $user, $mdp);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Vérifier si les données POST nécessaires sont présentes
    if (isset($_POST['idUser'], $_POST['idColleague'])) {
        $idUser = $_POST['idUser'];
        $idColleague = $_POST['idColleague'];

        try {
            $idDiscussion = $unControleur->createDiscussion(null, array($idUser, $idColleague), $idUser);
            // Envoyer l'ID de discussion dans la réponse
            echo $idDiscussion;
        } catch (PDOException $e) {
            echo json_encode(['error' => $e->getMessage()]);
        }
    } else {
        echo json_encode(['error' => 'Paramètres manquants']);
    }
} else {
    echo json_encode(['error' => 'Méthode non autorisée']);
}
