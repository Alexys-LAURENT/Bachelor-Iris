<?php

require_once("Controller/config_bdd.php");
require_once("Controller/controller.class.php");

$unControleur = new Controleur($serveur, $bdd, $user, $mdp);

$themeMode = $_POST['themeMode'];
$idUser = $_POST['idUser'];

$unControleur->toggleThemeMode($themeMode, $idUser);
