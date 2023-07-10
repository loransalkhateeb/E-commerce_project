<?php 
	require_once('dbConnect.php');	
	$sql = "SELECT * FROM `categories` where `Id_statetype` = '1'";
	$r = mysqli_query($con,$sql);
	$result = array();
	while($row = mysqli_fetch_array($r)){
		array_push($result,array(
			"Id"=>$row['Id'],
			"ImageURL"=>$row['ImageURL'],
			"Name"=>$row['Name'],
		));
	}
	echo json_encode(array('Categories'=>$result));
	mysqli_close($con);