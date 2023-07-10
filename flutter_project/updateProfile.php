<?php 
if($_SERVER['REQUEST_METHOD']=='POST'){
	$ID  = $_POST['Id'];
	$Name = $_POST['Name'];
	$Phone = $_POST['phone'];
	require_once('dbConnect.php');		
	$sql = "UPDATE `users` SET `Name`='$Name',`Phone`='$Phone' WHERE `Id` = '$Id'";
	if(mysqli_query($con,$sql)){
		echo json_encode(array('result'=>true));
	}else{
		echo json_encode(array('result'=>false));
	}
	mysqli_close($con);
}
        