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
        $sql = "select idUser,nom,prenom,metier,pp from users where idEntreprise = (select idEntreprise from users where idUser = :idUser ) and not idUser = :idUser order by prenom, nom;";
        $donnees = array(
            ":idUser" => $idUser
        );
        $select = $this->unPDO->prepare($sql);
        $select->execute($donnees);
        return $select->fetchAll();
    }

    public function getAllMessages($idDiscussion)
    {
        $sql = "select messages.*, u.pp, u.nom, u.prenom from messages inner join users u on u.idUser = messages.idUser where idDiscussion = :idDiscussion order by timestamp asc;";
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
                $sql = "select idUser, nom,prenom,metier,pp,email,theme,statut from users where idUser = (select idUser from token where token = :token);";
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
            $sql = "select idUser, pp from users where idUser = (select idUser from discussions_users where idDiscussion = :idDiscussion and not idUser = :idUser limit 1)";
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

    public function getDiscussionCreatedBy($idDiscussion)
    {
        $sql = "select createdBy from discussions where idDiscussion = :idDiscussion ";
        $donnees = array(
            ":idDiscussion" => $idDiscussion
        );
        $select = $this->unPDO->prepare($sql);
        $select->execute($donnees);
        $createdBy = $select->fetch();
        return $createdBy;
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
        d.createdBy,
        SUBSTRING_INDEX(MAX(CONCAT(m.timestamp, ':', m.content)), ':', -1) AS dernier_message,
        MAX(m.idMessage) as idDernierMessage,
        (SELECT du_other.idUser
        FROM discussions_users du_other
        WHERE du_other.idDiscussion = d.idDiscussion AND du_other.idUser != :idUser
        LIMIT 1) AS idOtherUser
        FROM discussions d
        INNER JOIN discussions_users du ON d.idDiscussion = du.idDiscussion
        LEFT JOIN messages m ON d.idDiscussion = m.idDiscussion
        WHERE d.idDiscussion IN (
            SELECT idDiscussion
            FROM discussions_users
            WHERE idUser = :idUser
        )
        GROUP BY d.idDiscussion
        ORDER BY Max(m.timestamp) DESC
        ";

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
                GROUP_CONCAT(DISTINCT CASE WHEN u.idUser != :idUser THEN CONCAT(u.prenom,' ',u.nom) ELSE NULL END) AS participants
            FROM discussions d
            INNER JOIN discussions_users du ON d.idDiscussion = du.idDiscussion
            INNER JOIN users u ON du.idUser = u.idUser
            WHERE d.idDiscussion = $discussion[idDiscussion]
            GROUP BY d.idDiscussion";
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

    public function createDiscussion($nom, $members, $idUser)
    {

        try {

            //check if 1 to 1 discussion already exist
            if (count($members) == 2) {
                $sqlCheck = "SELECT idDiscussion
            FROM discussions_users
            WHERE idDiscussion IN (
                SELECT idDiscussion
                FROM discussions_users
                WHERE idUser = :idUser1
                OR idUser = :idUser2
                GROUP BY idDiscussion
                HAVING COUNT(DISTINCT idUser) = 2
            )
            GROUP BY idDiscussion
            HAVING COUNT(*) = 2;";
                $donnees = array(
                    ":idUser1" => $members[0],
                    ":idUser2" => $members[1]
                );
                $select = $this->unPDO->prepare($sqlCheck);
                $select->execute($donnees);
                $discussion = $select->fetch();
                if ($select->rowCount() == 1) {
                    return $discussion['idDiscussion'];
                }
            }

            if (count($members) == 2) {
                $sql = "insert into discussions (nom) values (:nom);";
                $donnees = array(
                    ":nom" => $nom
                );
            } else {
                $sql = "insert into discussions (nom, createdBy) values (:nom, :createdBy);";
                $donnees = array(
                    ":nom" => $nom,
                    ":createdBy" => $idUser
                );
            }
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
            return $idDiscussion;
        } catch (PDOException $e) {
            echo $e->getMessage();
            return;
        }
    }

    public function renameDiscussion($idDiscussion, $nom)
    {
        try {
            $sql = "update discussions set nom = :nom where idDiscussion = :idDiscussion;";
            $donnees = array(
                ":nom" => $nom,
                ":idDiscussion" => $idDiscussion
            );
            $update = $this->unPDO->prepare($sql);
            $update->execute($donnees);
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

    public function deleteDiscussion($idDiscussion)
    {
        try {
            $donnees = array(
                ":idDiscussion" => $idDiscussion
            );

            $sql = "delete from message_reads where idMessage in (select idMessage from messages where idDiscussion = :idDiscussion);";
            $delete = $this->unPDO->prepare($sql);
            $delete->execute($donnees);

            $sql = "delete from messages where idDiscussion = :idDiscussion;";
            $delete = $this->unPDO->prepare($sql);
            $delete->execute($donnees);

            $sql = "delete from discussions_users where idDiscussion = :idDiscussion;";
            $delete = $this->unPDO->prepare($sql);
            $delete->execute($donnees);

            $sql = "delete from discussions where idDiscussion = :idDiscussion;";
            $delete = $this->unPDO->prepare($sql);
            $delete->execute($donnees);
        } catch (PDOException $e) {
            echo $e->getMessage();
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

    public function getUserStatus($idUser)
    {
        $sql = "select statut from users where idUser = :idUser;";
        $donnees = array(
            ":idUser" => $idUser
        );
        $select = $this->unPDO->prepare($sql);
        $select->execute($donnees);
        $status = $select->fetch();
        return $status;
    }

    public function updateUserStatus($newStatus, $idUser)
    {
        try {
            $sql = "update users set statut = :newStatus where idUser = :idUser;";
            $donnees = array(
                ":newStatus" => $newStatus,
                ":idUser" => $idUser
            );
            $update = $this->unPDO->prepare($sql);
            $update->execute($donnees);
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

    public function toggleThemeMode($themeMode, $idUser)
    {
        try {
            $sql = "update users set theme = :themeMode where idUser = :idUser;";
            $donnees = array(
                ":themeMode" => $themeMode,
                ":idUser" => $idUser
            );
            $update = $this->unPDO->prepare($sql);
            $update->execute($donnees);
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

    public function setSeen($idUser, $allIdsMessages)
    {
        try {
            foreach ($allIdsMessages as $idMessage) {
                $sql = "SELECT idMessageRead FROM message_reads WHERE idMessage = :idMessage and idUser = :idUser";
                $stmt = $this->unPDO->prepare($sql);
                $donnees = array(
                    ":idMessage" => $idMessage,
                    ":idUser" => $idUser
                );
                $stmt->execute($donnees);
                if ($stmt->rowCount() == 0) {
                    $sql = "select idUser from messages where idMessage = :idMessage";
                    $stmt = $this->unPDO->prepare($sql);
                    $donnees = array(
                        ":idMessage" => $idMessage
                    );
                    $stmt->execute($donnees);
                    $idUserMessage = $stmt->fetch();
                    $idUserMessage = $idUserMessage['idUser'];

                    if ($idUserMessage != $idUser) {
                        $sql = "INSERT INTO message_reads ( idMessage,  idUser,  timestamp) VALUES (:idMessage, :idUser, :timestamp)";
                        $stmt = $this->unPDO->prepare($sql);
                        $donnees = array(
                            ":idMessage" => $idMessage,
                            ":idUser" => $idUser,
                            ":timestamp" => date("Y-m-d H:i:s")
                        );
                        $stmt->execute($donnees);
                    }
                }
            }
        } catch (PDOException $e) {
            echo "Erreur : " . $e->getMessage();
        }
    }

    function isMessageRead($idMessage, $idUser)
    {
        $sql = "SELECT idUser FROM messages WHERE idMessage = :idMessage";
        $stmt = $this->unPDO->prepare($sql);
        $donnees = array(
            ":idMessage" => $idMessage
        );
        $stmt->execute($donnees);
        $idUserMessage = $stmt->fetch();
        $idUserMessage = $idUserMessage['idUser'];

        if ($idUserMessage == $idUser) {
            return true;
        }

        $sql = "SELECT idMessageRead FROM message_reads WHERE idMessage = :idMessage and idUser = :idUser";
        $stmt = $this->unPDO->prepare($sql);
        $donnees = array(
            ":idMessage" => $idMessage,
            ":idUser" => $idUser
        );
        $stmt->execute($donnees);
        if ($stmt->rowCount() == 0) {
            return false;
        } else {
            return true;
        }
    }

    // STATISTIQUES ////////////////////////////////

    public function getTotalMessStats($idDiscussion)
    {
        $sql = "SELECT 
        IFNULL(COUNT(m.idMessage), 0) as totalMess, 
        CONCAT(u.prenom, ' ', u.nom) as nom
            FROM 
                users u
            LEFT JOIN 
                messages m ON u.idUser = m.idUser AND m.idDiscussion = :idDiscussion
            WHERE 
                u.idUser IN (SELECT idUser FROM discussions_users WHERE idDiscussion = :idDiscussion)
            GROUP BY 
        u.idUser";
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
