<?php

require_once("Controller/config_bdd.php");
require_once("Controller/controller.class.php");

$unControleur = new Controleur($serveur, $bdd, $user, $mdp);

$message = htmlspecialchars($_POST['message']);
$idDiscussion = $_POST['idDiscussion'];
$idUser = $_POST['idUser'];

$isSend = $unControleur->sendMessage($idDiscussion, $idUser, $message);


header('Content-Type: application/json');
echo json_encode($isSend);
