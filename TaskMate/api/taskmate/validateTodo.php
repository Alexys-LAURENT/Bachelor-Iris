<?php
	require_once ("../controleur/controleur.class.php"); 
	if (isset($_REQUEST['idTodo'])){
		Controleur :: validateTodo($_REQUEST['idTodo']);
    print ("[{'sucess':true}]");
	}else{
		print("Error");
	}
?>