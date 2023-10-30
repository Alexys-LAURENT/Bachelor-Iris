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

    public function getAllColleagues($idUser)
    {
        $sql = "select * from users where idEntreprise = (select idEntreprise from users where idUser = :idUser ) and not idUser = :idUser ;";
        $donnees = array(
            ":idUser" => $idUser
        );
        $select = $this->unPDO->prepare($sql);
        $select->execute($donnees);
        return $select->fetchAll();
    }

    public function getAllMessages($idDiscussion)
    {
        $sql = "select * from messages where idDiscussion = :idDiscussion order by timestamp asc;";
        $donnees = array(
            ":idDiscussion" => $idDiscussion
        );
        $select = $this->unPDO->prepare($sql);
        $select->execute($donnees);
        return $select->fetchAll();
    }

    public function checkToken($token)
    {
        $sql = "select * from token where token = :token;";
        $donnees = array(
            ":token" => $token
        );
        $select = $this->unPDO->prepare($sql);
        $select->execute($donnees);
        $token = $select->fetch();

        if ($select->rowCount() == 1) {
            $tokenDate = $token['expireAt'];
            if (strtotime($tokenDate) < strtotime(date("Y-m-d H:i:s"))) {
                return false;
            } else {
                $sql = "select * from users where idUser = (select idUser from token where token = :token);";
                $donnees = array(
                    ":token" => $token['token']
                );
                $select = $this->unPDO->prepare($sql);
                $select->execute($donnees);
                $user = $select->fetch();
                return $user;
            }
        } else {
            return false;
        }
    }

    public function getConversationName($idUser, $idDiscussion)
    {
        $sql = "select * from users where idUser in (select idUser from discussions_users where idDiscussion = :idDiscussion and idUser != :idUser);";
        $donnees = array(
            ":idDiscussion" => $idDiscussion,
            ":idUser" => $idUser
        );
        $select = $this->unPDO->prepare($sql);
        $select->execute($donnees);
        $users = $select->fetchAll();
        return $users;
    }

    public function sendMessage($idDiscussion, $idUser, $message)
    {
        try {
            $sql = "insert into messages (idDiscussion,idUser,content) values (:idDiscussion, :idUser, :content);";
            $donnees = array(
                ":idDiscussion" => $idDiscussion,
                ":idUser" => $idUser,
                ":content" => $message
            );
            $insert = $this->unPDO->prepare($sql);
            $insert->execute($donnees);
            return true;
        } catch (PDOException $e) {
            echo $e->getMessage();
            return false;
        }
    }
}
