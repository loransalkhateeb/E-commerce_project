<?php 
if($_SERVER['REQUEST_METHOD']=='POST'){
	$Id = $_POST['Id'];
	$Count = $_POST['Count'];
	require_once('dbConnect.php');		
	$sql = "UPDATE `cart` set `Count` = '$Count' where `Id` = '$Id';";
	if(mysqli_query($con,$sql)){
		echo json_encode(array('result'=>true));
	}else{
		echo json_encode(array('result'=>false));
	}
	mysqli_close($con);
}
        