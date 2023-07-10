<?php 
if($_SERVER['REQUEST_METHOD']=='POST'){
	$Name = $_POST['Name'];
	$Email = $_POST['Email'];
	$Phone = $_POST['Phone'];
	$Password = $_POST['Password'];
	require_once('dbConnect.php');		
	$sql = "INSERT INTO `users` (`Email`,`Name`,`Phone`,`Password`) 
	VALUES ('$Email','$Name','$Phone','$Password');";
	if(mysqli_query($con,$sql)){
		echo json_encode(array('result'=>true));
	}else{
		echo json_encode(array('result'=>false,"msg"=>"email is not  exist"));
	}
	mysqli_close($con);
}
        