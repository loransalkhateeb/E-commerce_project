<?php 
if($_SERVER['REQUEST_METHOD']=='POST'){
    $Id_users = $_POST['Id_users'];
	require_once('dbConnect.php');	
	$sql = "SELECT cart.Id_items,cart.Id,cart.Count,
	items.Name,items.ImageURL,items.Price 
			FROM `cart` join `items` 
			on(cart.Id_items = items.Id)
			WHERE cart.Id_users = '$Id_users'";
	$r = mysqli_query($con,$sql);
	$result = array();
	while($row = mysqli_fetch_array($r)){
		array_push($result,array(
			"Id_items"=>$row['Id_items'],
			"Id"=>$row['Id'],
			"Count"=>(int)$row['Count'],
			"ImageURL"=>$row['ImageURL'],
			"Price"=>(double)$row['Price'],
			"Name"=>$row['Name'],
		));
	}
	echo json_encode(array('cart'=>$result));
	mysqli_close($con);
}
