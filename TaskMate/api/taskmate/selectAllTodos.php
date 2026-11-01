<?php
	require_once ("../controleur/controleur.class.php"); 
	if (isset($_REQUEST['idUser'])){
		print (Controleur :: selectAllTodos($_REQUEST['idUser']));
	}else{
		print("[]");
	}
?>