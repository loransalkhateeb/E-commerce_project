<?php 
if($_SERVER['REQUEST_METHOD']=='POST'){
    $Id_shops = $_POST['Id_shops'];
	require_once('dbConnect.php');	
	$sql = "SELECT * FROM `items` 
	where `Id_statetype` = '1' and `Id_shops` = '$Id_shops'";
	$r = mysqli_query($con,$sql);
	$result = array();
	while($row = mysqli_fetch_array($r)){
		array_push($result,array(
			"Id"=>$row['Id'],
			"Name"=>$row['Name'],
			"ImageURL"=>$row['ImageURL'],
			"Price"=>(double)$row['Price'],
			"Description"=>$row['Description'],
		));
	}
	echo json_encode(array('items'=>$result));
	mysqli_close($con);
}
