<?php
require_once("model/modele.class.php");

class Controleur
{
    private $unModele;

    public function __construct($serveur, $bdd, $user, $mdp)
    {
        $this->unModele = new Modele($serveur, $bdd, $user, $mdp);
    }
}
