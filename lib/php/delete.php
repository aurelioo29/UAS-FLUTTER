<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "uas_mobile";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Ambil data dari body request
$data = json_decode(file_get_contents("php://input"));

$id = $data->id; 

$sql = "DELETE FROM transactions WHERE id = $id"; 

if ($conn->query($sql) === TRUE) {
    echo json_encode(array("message" => "Data deleted successfully"));
} else {
    echo json_encode(array("error" => $conn->error));
}

$conn->close();
?>
