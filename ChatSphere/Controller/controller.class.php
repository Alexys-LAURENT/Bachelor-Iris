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
}
