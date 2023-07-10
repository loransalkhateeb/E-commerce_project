<?php 
if($_SERVER['REQUEST_METHOD']=='POST'){
    $Id_categories = $_POST['Id_categories'];
	require_once('dbConnect.php');	
	$sql = "SELECT * FROM `shops` where `Id_statetype` = '1' and `Id_categories` = '$Id_categories'";
	$r = mysqli_query($con,$sql);
	$result = array();
	while($row = mysqli_fetch_array($r)){
		array_push($result,array(
			"Id"=>$row['Id'],
			"ImageURL"=>$row['ImageURL'],
			"Name"=>$row['Name'],
		));
	}
	echo json_encode(array('shops'=>$result));
	mysqli_close($con);
}
