<?php
require_once("Controller/config_bdd.php");
require_once("Controller/controller.class.php");
$unControleur = new Controleur($serveur, $bdd, $user, $mdp);

$idUser = $_POST['idUser'];
$allIdsMessages = json_decode($_POST['messages']);
$test = $unControleur->setSeen($idUser, $allIdsMessages);
