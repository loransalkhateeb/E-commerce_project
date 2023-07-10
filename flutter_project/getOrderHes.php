<?php 
if($_SERVER['REQUEST_METHOD']=='POST'){
    $Id_users = $_POST['Id_users'];
	require_once('dbConnect.php');	
	$sql = "SELECT * FROM `orders` where `Id_users` = '$Id_users'";
	$r = mysqli_query($con,$sql);
	$result = array();
	while($row = mysqli_fetch_array($r)){
        $Id_orderstate  = $row['Id_orderstate'];
        $sql = "SELECT * FROM `orderstate` where `Id` = '$Id_orderstate'";
        $r2 = mysqli_query($con,$sql);
        $row2 = mysqli_fetch_array($r2);
		array_push($result,array(
			"Id"=>$row['Id'],
			"Note"=>$row['Note'],
			"TotalPrice"=>$row['TotalPrice'],
			"Longitude"=>$row['Longitude'],
			"Latitude"=>$row['Latitude'],
			"orderstate"=>$row2['Name'],

		));
	}
	echo json_encode(array('orders'=>$result));
	mysqli_close($con);
}