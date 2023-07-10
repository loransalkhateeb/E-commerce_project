<?php 
if($_SERVER['REQUEST_METHOD']=='POST'){
    $Id_items = $_POST['Id_items'];
	require_once('dbConnect.php');	
	$sql = "SELECT * FROM `itemimages` where `Id_items` = '$Id_items'";
	$r = mysqli_query($con,$sql);
	$result = array();
	while($row = mysqli_fetch_array($r)){
		array_push($result,array(
			"Id"=>$row['Id'],
			"ImageURL"=>$row['ImageURL'],
		));
	}
	echo json_encode(array('Images'=>$result));
	mysqli_close($con);
}