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

    public function getUserNameById($idUser)
    {
        $sql = "select nom,prenom from users where idUser = :idUser;";
        $donnees = array(
            ":idUser" => $idUser
        );
        $select = $this->unPDO->prepare($sql);
        $select->execute($donnees);
        $user = $select->fetch();
        return $user['prenom'] . ' ' . $user['nom'];
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
        $sql = "select messages.*, u.pp from messages inner join users u on u.idUser = messages.idUser where idDiscussion = :idDiscussion order by timestamp asc;";
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

    public function getDiscussionName($idDiscussion, $idUser)
    {
        if ($this->isDiscussionAGroup($idDiscussion) == true) {
            $sql = "select nom from discussions where idDiscussion = :idDiscussion ";
            $donnees = array(
                ":idDiscussion" => $idDiscussion
            );
            $select = $this->unPDO->prepare($sql);
            $select->execute($donnees);
            $name = $select->fetch();
            return $name;
        } else {
            $sql = "select prenom, nom from users where idUser = (select idUser from discussions_users where idDiscussion = :idDiscussion and not idUser = :idUser limit 1)";
            $donnees = array(
                ":idDiscussion" => $idDiscussion,
                ":idUser" => $idUser
            );
            $select = $this->unPDO->prepare($sql);
            $select->execute($donnees);
            $name = $select->fetch();
            $name = $name['prenom'] . ' ' . $name['nom'];
            return array(
                "nom" => $name
            );
        }
    }

    public function getDiscussionImage($idDiscussion, $idUser)
    {
        if ($this->isDiscussionAGroup($idDiscussion) == true) {
            return array(
                "pp" => "group.png"
            );
        } else {
            $sql = "select pp from users where idUser = (select idUser from discussions_users where idDiscussion = :idDiscussion and not idUser = :idUser limit 1)";
            $donnees = array(
                ":idDiscussion" => $idDiscussion,
                ":idUser" => $idUser
            );
            $select = $this->unPDO->prepare($sql);
            $select->execute($donnees);
            $image = $select->fetch();
            return $image;
        }
    }

    public function isDiscussionAGroup($idDiscussion)
    {
        $sql = "select * from discussions_users where idDiscussion = :idDiscussion";
        $donnees = array(
            ":idDiscussion" => $idDiscussion
        );
        $select = $this->unPDO->prepare($sql);
        $select->execute($donnees);
        $users = $select->fetchAll();
        if (count($users) > 2) {
            return true;
        } else {
            return false;
        }
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

    public function getDiscussionsDetails($idUser)
    {
        $sql = "SELECT d.idDiscussion,
        d.nom,
        SUBSTRING_INDEX(MAX(CONCAT(m.timestamp, ':', m.content)), ':', -1) AS dernier_message
        FROM discussions d
        INNER JOIN discussions_users du ON d.idDiscussion = du.idDiscussion
        LEFT JOIN messages m ON d.idDiscussion = m.idDiscussion
        WHERE d.idDiscussion IN (
            SELECT idDiscussion
            FROM discussions_users
            WHERE idUser = :idUser
        )
        GROUP BY d.idDiscussion";

        $donnees = array(
            ":idUser" => $idUser
        );
        $select = $this->unPDO->prepare($sql);
        $select->execute($donnees);
        $discussions = $select->fetchAll();

        foreach ($discussions as $i => $discussion) {
            $image = $this->getDiscussionImage($discussion['idDiscussion'], $idUser);
            $discussion['pp'] = $image['pp'];
            $discussions[$i] = $discussion;

            if ($this->isDiscussionAGroup($discussion['idDiscussion']) == false) {
                $sql = "SELECT 
                d.idDiscussion,
                GROUP_CONCAT(DISTINCT CASE WHEN u.idUser != :idUser THEN CONCAT(u.prenom,' ',u.nom) ELSE NULL END ORDER BY m.timestamp ASC) AS participants,
                SUBSTRING_INDEX(MAX(CONCAT(m.timestamp, ':', m.content)), ':', -1) AS dernier_message
            FROM discussions d
            INNER JOIN discussions_users du ON d.idDiscussion = du.idDiscussion
            INNER JOIN users u ON du.idUser = u.idUser
            LEFT JOIN messages m ON d.idDiscussion = m.idDiscussion
            WHERE d.idDiscussion IN (
                SELECT idDiscussion
                FROM discussions_users
                WHERE idUser = :idUser
            )
            GROUP BY d.idDiscussion LIMIT 0,100";
                $donnees = array(
                    ":idUser" => $idUser
                );
                $select = $this->unPDO->prepare($sql);
                $select->execute($donnees);
                $discussionWithPersonName = $select->fetch();
                $discussion['nom'] = $discussionWithPersonName['participants'];
                $discussions[$i] = $discussion;
            }
        }
        return $discussions;
    }

    public function createDiscussion($nom, $members)
    {
        try {
            $sql = "insert into discussions (nom) values (:nom);";
            $donnees = array(
                ":nom" => $nom
            );
            $insert = $this->unPDO->prepare($sql);
            $insert->execute($donnees);
            $idDiscussion = $this->unPDO->lastInsertId();

            foreach ($members as $member) {
                $sql = "insert into discussions_users (idDiscussion, idUser) values (:idDiscussion, :idUser);";
                $donnees = array(
                    ":idDiscussion" => $idDiscussion,
                    ":idUser" => $member
                );
                $insert = $this->unPDO->prepare($sql);
                $insert->execute($donnees);
            }
            return true;
        } catch (PDOException $e) {
            echo $e->getMessage();
            return false;
        }
    }

    public function checkIdDiscussion($idDiscussion, $idUser)
    {
        $sql = "select * from discussions_users where idDiscussion = :idDiscussion and idUser = :idUser;";
        $donnees = array(
            ":idDiscussion" => $idDiscussion,
            ":idUser" => $idUser
        );
        $select = $this->unPDO->prepare($sql);
        $select->execute($donnees);
        $discussion = $select->fetch();
        if ($select->rowCount() == 1) {
            return true;
        } else {
            return false;
        }
    }

    // STATISTIQUES ////////////////////////////////

    public function getTotalMessStats($idDiscussion)
    {
        $sql = "SELECT count(m.idMessage) as totalMess, CONCAT(u.nom,' ',u.prenom) as nom from messages m INNER JOIN users u on m.idUser = u.idUser where m.`idDiscussion` = :idDiscussion GROUP BY m.`idUser` ";
        $donnees = array(
            ":idDiscussion" => $idDiscussion
        );
        $select = $this->unPDO->prepare($sql);
        $select->execute($donnees);
        $totalMess = $select->fetchAll();
        return $totalMess;
    }

    public function getTotalMessByMonthByUsersStats($idDiscussion)
    {
        $totalAllUser = [];

        $sql = 'select idUser from discussions_users where idDiscussion = :idDiscussion';
        $donnees = array(
            ":idDiscussion" => $idDiscussion
        );
        $select = $this->unPDO->prepare($sql);
        $select->execute($donnees);
        $users = $select->fetchAll();

        foreach ($users as $user) {
            $sql = "SELECT 
        DATE_FORMAT(DATE_SUB(NOW(), INTERVAL n MONTH), '%Y-%m') AS mois,
        u.prenom, 
        u.nom, 
        IFNULL(COUNT(m.idMessage), 0) AS nombre_total_de_messages
    FROM
        (SELECT 0 AS n
         UNION ALL SELECT 1
         UNION ALL SELECT 2
         UNION ALL SELECT 3
         UNION ALL SELECT 4
         UNION ALL SELECT 5
         UNION ALL SELECT 6
         UNION ALL SELECT 7
         UNION ALL SELECT 8
         UNION ALL SELECT 9
         UNION ALL SELECT 10
         UNION ALL SELECT 11) AS months
    LEFT JOIN users u ON u.idUser = :idUser
    LEFT JOIN discussions d ON d.idDiscussion = :idDiscussion
    LEFT JOIN messages m ON DATE_FORMAT(DATE_SUB(NOW(), INTERVAL months.n MONTH), '%Y-%m') = DATE_FORMAT(m.timestamp, '%Y-%m')
                        AND m.idUser = u.idUser
                        AND m.idDiscussion = d.idDiscussion
    WHERE DATE_FORMAT(DATE_SUB(NOW(), INTERVAL months.n MONTH), '%Y-%m') >= DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 11 MONTH), '%Y-%m')
    GROUP BY mois, u.prenom, u.nom
    ORDER BY mois";
            $donnees = array(
                ":idDiscussion" => $idDiscussion,
                ":idUser" => $user['idUser']
            );
            $select = $this->unPDO->prepare($sql);
            $select->execute($donnees);
            $totalMessByMonthByOneUser = $select->fetchAll();
            array_push($totalAllUser, $totalMessByMonthByOneUser);
        }
        return $totalAllUser;
    }
}
