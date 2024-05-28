<?php
	class Modele 
	{
		private $unPDO ; 
		public function __construct (){
			try{
				$this->unPDO=new PDO("mysql:host=XXX;dbname=XXX","XXX","XXX");
			}
			catch (PDOException $exp){
				echo "<br> Erreur connexion : ".$exp->getMessage (); 
			}
		}
		public function verifConnexion ($email, $mdp){
			$requete ="select idUser,idEntreprise,nom,prenom,email,pp from users where email = :email and hashedPass = :mdp;";
			$donnees = array(":email"=>$email, ":mdp"=>$mdp); 
			$select = $this->unPDO->prepare ($requete); 
			$select->execute ($donnees); 
			return $select->fetch (); 
		}
		public function createTodo ($tab){
			$data = "model : \n". $tab['description'] . "\n" . $tab['timestamp'] . "\n" . $tab['idUser'] . "\n";
			file_put_contents("../log.txt", $data, FILE_APPEND);
			try {
				$requete="insert into todos (description,timestamp,idUser,etat) values (:description, :timestamp, :idUser, 'En cours')";
				$donnees = array(	":description"=>$tab['description'], 
									":timestamp"=>$tab['timestamp'],
									":idUser"=>$tab['idUser']
								); 
				$select = $this->unPDO->prepare ($requete); 
				$select->execute ($donnees); 
				file_put_contents("../log.txt", "//////////////////////", FILE_APPEND);
			} catch (PDOException $exp) {
				file_put_contents('../log.txt', date('Y-m-d H:i:s') . ' - ' . $exp->getMessage(), FILE_APPEND);
			}
		}

		public function updateTodo ($tab){
			$data = "model : \n". $tab['description'] . "\n" . $tab['timestamp'] . "\n" . $tab['idTodo'] . "\n";
			file_put_contents("../log.txt", $data, FILE_APPEND);
			try {
				$requete="update todos set description = :description, timestamp = :timestamp where idToDo = :idTodo";
				$donnees = array(	":description"=>$tab['description'], 
									":timestamp"=>$tab['timestamp'],
									":idTodo"=>$tab['idTodo']
								); 
				$select = $this->unPDO->prepare ($requete); 
				$select->execute ($donnees); 
				file_put_contents("../log.txt", "//////////////////////", FILE_APPEND);
			} catch (PDOException $exp) {
				file_put_contents('../log.txt', date('Y-m-d H:i:s') . ' - ' . $exp->getMessage(), FILE_APPEND);
			}
		}

		public function validateTodo ($idTodo){
			$requete="update todos set etat = 'Terminé' where idToDo = :idToDo;"; 
			$donnees = array(":idToDo"=>$idTodo); 
			$select = $this->unPDO->prepare ($requete); 
			$select->execute ($donnees); 
		}


		public function selectAllTodos ($idUser){
			$requete ="select * from todos where idUser = :idUser and etat = 'En cours' ; ";
			$donnees = array(":idUser"=>$idUser); 
			$select = $this->unPDO->prepare ($requete);
			$select->execute ($donnees);
			return $select->fetchAll ();
		}
		
		public function deleteTodo ($idTodo){
			$requete="delete from todos where idToDo = :idToDo;"; 
			$donnees = array(":idToDo"=>$idTodo); 
			$select = $this->unPDO->prepare ($requete); 
			$select->execute ($donnees); 
		}

	}
	
?>