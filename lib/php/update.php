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

$data = json_decode(file_get_contents("php://input"));

$id = $data->id; 
$newName = $data->newName; 
$newCategory = $data->newCategory;
$newSatuan = $data->newSatuan;
$newQuantity = $data->newQuantity;
$newTotal = $data->newTotal;

$sql = "UPDATE transactions SET name = '$newName', category = '$newCategory', satuan = '$newSatuan', quantity = '$newQuantity', total = '$newTotal' WHERE id = $id"; // Sesuaikan dengan nama tabel dan field di database Anda

if ($conn->query($sql) === TRUE) {
    echo json_encode(array("message" => "Data updated successfully"));
} else {
    echo json_encode(array("error" => $conn->error));
}

$conn->close();
