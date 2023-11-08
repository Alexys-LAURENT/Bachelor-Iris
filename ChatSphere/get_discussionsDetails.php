<?php
require_once("Controller/config_bdd.php");
require_once("Controller/controller.class.php");
$unControleur = new Controleur($serveur, $bdd, $user, $mdp);

$idUser = $_GET['idUser'];
$discussions = $unControleur->getDiscussionsDetails($idUser);


// add a new field to all discussion in $discussions
foreach ($discussions as $i => $discussion) {
    $md5 = substr(md5(utf8_encode($discussion['idOtherUser'])), 0, 6);
    $discussion['color'] = $md5;
    $discussion['idDernierMessage'] != null ? $discussion['isMessageRead'] = $unControleur->isMessageRead($discussion['idDernierMessage'], $idUser) : $discussion['isMessageRead'] = 5;
    $discussions[$i] = $discussion;
}



header('Content-Type: application/json');
echo json_encode($discussions);
