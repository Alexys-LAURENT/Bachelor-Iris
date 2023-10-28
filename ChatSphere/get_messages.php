<?php
require_once("Controller/config_bdd.php");
require_once("Controller/controller.class.php");
$unControleur = new Controleur($serveur, $bdd, $user, $mdp);

$idDiscussion = $_GET['idDiscussion'];
$messagesDiscussion = $unControleur->getAllMessages($idDiscussion);


header('Content-Type: application/json');
echo json_encode($messagesDiscussion);
