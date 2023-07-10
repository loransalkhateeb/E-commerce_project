<?php 
if($_SERVER['REQUEST_METHOD']=='POST'){
    require_once('dbConnect.php');
    $URL = $_POST['URL'];
    $target_dir = "bannerimages/";
    $imageFileType = strtolower(pathinfo(basename(
        $_FILES["fileToUpload"]["name"]),PATHINFO_EXTENSION));
    $sql = "INSERT INTO `bannerimages` (`URL`)
    VALUES ('$URL')";
    if(mysqli_query($con,$sql)){
        $Id = mysqli_insert_id($con);
        $newFileName = $target_dir. $Id . '.' . $imageFileType;
        move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $newFileName);
        $sql2 = "UPDATE `bannerimages` SET `ImageURL` =  '$newFileName' WHERE Id = '$Id'";
        mysqli_query($con,$sql2);
        echo json_encode(array('result'=>true));
    }else{
        echo json_encode(array('result'=>false));
    }
    mysqli_close($con);
}