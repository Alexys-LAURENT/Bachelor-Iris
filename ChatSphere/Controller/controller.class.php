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

    public function getConversationName($idUser, $idDiscussion)
    {
        return $this->unModele->getConversationName($idUser, $idDiscussion);
    }

    public function sendMessage($idDiscussion, $idUser, $message)
    {
        return $this->unModele->sendMessage($idDiscussion, $idUser, $message);
    }
}
