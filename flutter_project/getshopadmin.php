<?php
if($_SERVER['REQUEST_METHOD']=='POST'){
    require_once('dbconnect.php');
    $sql="SELECT * from `shops`";
    $r=mysqli_query($con,$sql);
    $result=array();
    while($roe=mysqli_fetch_array($r)){
        array_push(
            $result,array(
                "Id"=>$row['Id'],
                "ImageUrl"=>$row['ImageUrl'],
                "Name"=>$row['Name'],
                "Id_statetype"=>$row['Id_statetype']
            )
            );
    }
    echo json_encode(array('shops'=>$result));
	mysqli_close($con);
}



?>