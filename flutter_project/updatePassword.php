<?php 
if($_SERVER['REQUEST_METHOD']=='POST'){
	$Id = $_POST['Id'];
	$Password = $_POST['Password'];
	require_once('dbConnect.php');		
	$sql = "UPDATE `users` SET `Password`='$Password' WHERE `Id` = '$Id'";
	if(mysqli_query($con,$sql)){
		echo json_encode(array('result'=>true));
	}else{
		echo json_encode(array('result'=>false));
	}
	mysqli_close($con);
}
        