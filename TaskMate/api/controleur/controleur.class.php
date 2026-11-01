<?php
	require_once ("../modele/modele.class.php"); 
	class Controleur {
		private static $unModele  ; 

		public static function verifConnexion ($email, $mdp){
			Controleur::$unModele = new Modele (); 
			$resultat = Controleur::$unModele->verifConnexion($email, $mdp); 
			if ($resultat != null){
					$tab = array("idUser"=>$resultat["idUser"], 
								 "idEntreprise"=> $resultat["idEntreprise"], 
								 "nom"=> $resultat["nom"], 
								 "prenom"=> $resultat["prenom"], 
								 "email"=> $resultat["email"], 
								 "pp"=> $resultat["pp"]
								);
					return "[".json_encode($tab)."]";
			} else {
				return "[]";
			}
		}

		public static function validateTodo($idTodo){
			Controleur::$unModele = new Modele (); 
			Controleur::$unModele->validateTodo ($idTodo); 
		}

		public static function deleteTodo($idTodo){
			Controleur::$unModele = new Modele (); 
			Controleur::$unModele->deleteTodo ($idTodo); 
		}

		public static function createTodo ($tab){
			$data = "controleur : \n". $tab['description'] . "\n" . $tab['timestamp'] . "\n" . $tab['idUser'] . "\n";
			file_put_contents("../log.txt", $data, FILE_APPEND);
			Controleur::$unModele = new Modele ();
			Controleur::$unModele->createTodo($tab); 
		}

		public static function updateTodo ($tab){
			$data = "controleur : \n". $tab['description'] . "\n" . $tab['timestamp'] . "\n" . $tab['idTodo'] . "\n";
			file_put_contents("../log.txt", $data, FILE_APPEND);
			Controleur::$unModele = new Modele ();
			Controleur::$unModele->updateTodo($tab); 
		}

		public static function selectAllTodos ($idUser){
			Controleur::$unModele = new Modele ();
			$lesResultats = Controleur :: $unModele-> selectAllTodos($idUser); 
			$tab = array (); 
			foreach ($lesResultats as $resultat) {
				$ligne = array("idToDo"=>$resultat["idToDo"], 
								 "idUser"=> $resultat["idUser"], 
								 "description"=> $resultat["description"], 
								 "timestamp"=> $resultat["timestamp"], 
								 "etat"=> $resultat["etat"] 
								);
				$tab[] = $ligne ; 
			}
			return json_encode($tab);
		}
	}

?>





















