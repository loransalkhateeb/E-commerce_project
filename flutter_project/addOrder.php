<?php 
if($_SERVER['REQUEST_METHOD']=='POST'){
    $Id_users = $_POST['Id_users'];
    $Note = $_POST['Note'];
    $Longitude = $_POST['Longitude'];
    $Latitude = $_POST['Latitude'];
    $TotalPrice = $_POST['TotalPrice'];
    require_once('dbConnect.php');		
	$sql = "INSERT INTO `orders`( `Id_users`, `Note`, `Longitude`, `Latitude`, `TotalPrice`)
            VALUES ('$Id_users','$Note','$Longitude','$Latitude','$TotalPrice');";
    mysqli_query($con,$sql);
    $Id_order = $con->insert_id;

    $sqlSelectCart = "SELECT * from `cart` WHERE `Id_users` = '$Id_users'";
    $r_cart = mysqli_query($con,$sqlSelectCart);
	
	while($row_cart = mysqli_fetch_array($r_cart)){
        $Id_items = $row_cart['Id_items'];
        $Count = $row_cart['Count'];
        $sqlInsertOrderDet = "INSERT INTO `orderdet` (`Id_orders`, `Id_items`, `Count`) 
                                VALUES ('$Id_order','$Id_items','$Count')";

        mysqli_query($con,$sqlInsertOrderDet);
    }


    $sqlDeleteCart = "DELETE FROM `cart` WHERE `Id_users` = '$Id_users'";
    mysqli_query($con,$sqlDeleteCart);

    echo json_encode(array('result'=>true));
	mysqli_close($con);


}