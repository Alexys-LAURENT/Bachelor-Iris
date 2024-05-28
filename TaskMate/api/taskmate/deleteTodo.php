<?php
	require_once ("../controleur/controleur.class.php"); 
	if (isset($_REQUEST['idTodo'])){
		Controleur :: deleteTodo($_REQUEST['idTodo']);
    print ("[{'sucess':true}]");
	}else{
		print("Error");
	}
?>