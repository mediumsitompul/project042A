<?php
include "conn.php";

//LIVE FROM APPS
$username = $_POST['username'];
$password = $_POST['password'];
$name = $_POST['name'];
$birthday = $_POST['birthday'];
$province = $_POST['province'];
$regency = $_POST['regency'];
$kecamatan = $_POST['kecamatan'];
$kelurahan = $_POST['kelurahan'];


$username_='';

    if($username != '' AND $password !='' AND $name !='' AND $birthday !='') {
      
        $aSQL = "SELECT * from t_user where username=$username";
        $aQResult=mysqli_query($connect, $aSQL);
        while ($aRow = mysqli_fetch_array($aQResult))
        {
        $username_=$aRow["username"];
        echo json_encode('username_exist');
        }
        
        
    //if($username_ == NULL AND $kecamatan != NULL AND $kelurahan != NULL) {
    if($username_ == NULL) { //ORIGINAL
        $result2 = mysqli_query($connect,
        "insert into t_user
        set username='$username', password='$password', name='$name', birthday='$birthday', 
        province='$province', regency='$regency',
        kecamatan='$kecamatan', kelurahan='$kelurahan', 
        flagging='f03',
        
		c_profile='p-01', l_profile='page-01', datetime1=now() "
        );
        echo json_encode('success');
        }
        $username_=NULL;}
    else{
        echo json_encode('data_not_complete');
        }
        $username_=NULL;
?>
