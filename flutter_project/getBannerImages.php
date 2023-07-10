<?php 
	require_once('dbConnect.php');	
	$sql = "SELECT * FROM `bannerimages`";
	$r = mysqli_query($con,$sql);
	$result = array();
	while($row = mysqli_fetch_array($r)){
		array_push($result,array(
			"Id"=>$row['Id'],
			"ImageURL"=>$row['ImageURL'],
			"URL"=>$row['URL'],
		));
	}
	echo json_encode(array('Images'=>$result));
	mysqli_close($con);