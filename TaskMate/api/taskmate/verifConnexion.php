<?php
	require_once ("../controleur/controleur.class.php"); 

	if (isset($_REQUEST['email']) && isset($_REQUEST['mdp']))
	{
		$email = $_REQUEST['email']; 
		$mdp = $_REQUEST['mdp'] ; 

		print (Controleur :: verifConnexion($email, $mdp)); 
	}
	else 
	{
		print("[]");
	}
?>