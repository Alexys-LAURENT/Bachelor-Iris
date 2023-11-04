<?php

require_once("Controller/config_bdd.php");
require_once("Controller/controller.class.php");

$unControleur = new Controleur($serveur, $bdd, $user, $mdp);

$newStatus = $_POST['status'];
$idUser = $_POST['idUser'];

$isUpdate = $unControleur->updateUserStatus($newStatus, $idUser);


header('Content-Type: application/json');
echo json_encode($isUpdate);
