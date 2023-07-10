<?php 
if($_SERVER['REQUEST_METHOD']=='POST'){
	$Id_users = $_POST['Id_users'];
	$Id_items = $_POST['Id_items'];
	require_once('dbConnect.php');		
	$sql = "INSERT INTO `cart` (`Id_users`,`Id_items`) 
	VALUES ('$Id_users','$Id_items');";
	if(mysqli_query($con,$sql)){
		echo json_encode(array('result'=>true));
	}else{
		echo json_encode(array('result'=>false));
	}
	mysqli_close($con);
}
        