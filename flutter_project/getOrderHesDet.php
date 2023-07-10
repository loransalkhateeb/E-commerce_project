<?php 
if($_SERVER['REQUEST_METHOD']=='POST'){
    $Id_orders = $_POST['Id_orders'];
	require_once('dbConnect.php');	
	$sql = "SELECT * FROM `orderdet` join `items` on(`orderdet`.Id_items = `items`.Id ) 
    where `orderdet`.`Id_orders` = '$Id_orders'";
	$r = mysqli_query($con,$sql);
	$result = array();
	while($row = mysqli_fetch_array($r)){
		array_push($result,array(
			"Id_items"=>$row['Id_items'],
			"Count"=>$row['Count'],
			"Name"=>$row['Name'],
			"Price"=>$row['Price'],
			"ImageURL"=>$row['ImageURL'],
			
		));
	}
	echo json_encode(array('OrdersDet'=>$result));
	mysqli_close($con);
}