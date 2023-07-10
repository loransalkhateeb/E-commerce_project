<?php 
if($_SERVER['REQUEST_METHOD']=='POST'){
    require_once('dbConnect.php');
    $Name = $_POST['Name'];
    $Id_statustypes = $_POST['Id_statustypes'];
    $target_dir = "categoriesimages/";
    $imageFileType = strtolower(pathinfo(basename($_FILES["fileToUpload"]["name"]),PATHINFO_EXTENSION));
    $sql = "INSERT INTO `categories` (`Name`,`Id_statetype`)
    VALUES ('$Name','$Id_statustypes')";
    if(mysqli_query($con,$sql)){
        $Id = mysqli_insert_id($con);
        $newFileName = $target_dir. $Id . '.' . $imageFileType;
        move_uploaded_file($_FILES["fileToU
        pload"]["tmp_name"], $newFileName);
        $sql2 = "UPDATE `categories` SET `ImageURL` =  '$newFileName' WHERE Id = '$Id'";
        mysqli_query($con,$sql2);
        echo json_encode(array('result'=>true));
    }else{
        echo json_encode(array('result'=>false));
    }
    mysqli_close($con);
}