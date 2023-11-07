<?php
require_once("Model/model.class.php");

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
        $name = $this->unModele->getDiscussionName($idDiscussion, $idUser);
        $usersConv = $this->unModele->getDiscussionImage($idDiscussion, $idUser);
        if (isset($usersConv['idUser'])) {
            return array(
                "idUser" => $usersConv['idUser'],
                "nom" => $name['nom'],
                "pp" => $usersConv['pp']
            );
        } else {
            return array(
                "nom" => $name['nom'],
                "pp" => $usersConv['pp']
            );
        }
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
        return $this->unModele->createDiscussion($nom, $members);
    }

    public function checkIdDiscussion($idDiscussion, $idUser)
    {
        return $this->unModele->checkIdDiscussion($idDiscussion, $idUser);
    }

    public function getUserStatus($idUser)
    {
        return $this->unModele->getUserstatus($idUser);
    }

    public function updateUserStatus($newStatus, $idUser)
    {
        $this->unModele->updateUserStatus($newStatus, $idUser);
    }

    public function toggleThemeMode($themeMode, $idUser)
    {
        $this->unModele->toggleThemeMode($themeMode, $idUser);
    }

    public function setSeen($idUser, $allIdsMessages)
    {
        return $this->unModele->setSeen($idUser, $allIdsMessages);
    }

    public function isMessageRead($idMessage, $idUser)
    {
        return $this->unModele->isMessageRead($idMessage, $idUser);
    }

    // STATISTIQUES ///////////////////////////////

    public function getTotalMessStats($idDiscussion)
    {
        return $this->unModele->getTotalMessStats($idDiscussion);
    }

    public function getTotalMessByMonthByUsersStats($idDiscussion)
    {
        return $this->unModele->getTotalMessByMonthByUsersStats($idDiscussion);
    }
}
