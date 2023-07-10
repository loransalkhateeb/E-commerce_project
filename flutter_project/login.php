<?php
if($_SERVER['REQUEST_METHOD']=='POST'){
    $Email = $_POST['Email'];
    $password = $_POST['Password'];
    $sql = "SELECT * from users where Email = '$Email' and `Password` = '$password'";
    require_once("dbConnect.php");
    $result = mysqli_query($con, $sql);
    if(mysqli_num_rows($result)>0){
        $row = mysqli_fetch_array($result);
        echo json_encode(array('result'=>true, 
                            'Id'=> $row['Id'],
                            'Name'=> $row['Name'],
                            'Email'=> $row['Email'],
                            'Phone'=> $row['Phone'],
                            'UserType'=> $row['Id_usertype'],
                        )
                    );
    }else{
        echo json_encode(array('result'=>false, 'msg'=> 'email or password incorect'));
    }
    mysqli_close($con);
}



