<?php
require_once("model/model.class.php");

class Controleur
{
    private $unModele;

    public function __construct($serveur, $bdd, $user, $mdp)
    {
        $this->unModele = new Modele($serveur, $bdd, $user, $mdp);
    }

    public function getAllColleagues($idUser)
    {
        return $this->unModele->getAllColleagues($idUser);
    }

    public function getAllMessages($idDiscussion)
    {
        return $this->unModele->getAllMessages($idDiscussion);
    }

    public function checkToken($token)
    {
        return $this->unModele->checkToken($token);
    }

    public function getDiscussionInfo($idUser, $idDiscussion)
    {
        $name = $this->unModele->getDiscussionName($idDiscussion);
        $pp = $this->unModele->getDiscussionImage($idDiscussion, $idUser);
        return array(
            "nom" => $name['nom'],
            "pp" => $pp['pp']
        );
    }

    public function sendMessage($idDiscussion, $idUser, $message)
    {
        return $this->unModele->sendMessage($idDiscussion, $idUser, $message);
    }

    public function getDiscussionsDetails($idUser)
    {
        return $this->unModele->getDiscussionsDetails($idUser);
    }

    public function createDiscussion($nom, $members)
    {
        if ($nom == null) {
            $nom = $this->unModele->getUserNameById($members[0]);
        }
        $this->unModele->createDiscussion($nom, $members);
    }

    public function checkIdDiscussion($idDiscussion, $idUser)
    {
        return $this->unModele->checkIdDiscussion($idDiscussion, $idUser);
    }
}
