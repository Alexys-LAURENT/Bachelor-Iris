<?php
require_once("Controller/config_bdd.php");
require_once("Controller/controller.class.php");
$unControleur = new Controleur($serveur, $bdd, $user, $mdp);

$idUser = $_GET['idUser'];
$userLogedStatus = $unControleur->getUserStatus($idUser);


header('Content-Type: application/json');
echo json_encode($userLogedStatus);
