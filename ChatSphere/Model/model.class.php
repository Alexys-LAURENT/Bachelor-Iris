<?php
class Modele
{
    private $unPDO;

    public function __construct($serveur, $bdd, $user, $mdp)
    {
        $this->unPDO = null;
        try {
            $url = "mysql:host=" . $serveur . ";dbname=" . $bdd;
            $this->unPDO = new PDO(
                $url,
                $user,
                $mdp,
                array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8")
            );
        } catch (PDOException $exp) {
            echo "<br> Erreur de connexion à la BDD!";
            echo $exp->getMessage();
        }
    }
}
