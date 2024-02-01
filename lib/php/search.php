<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Sesuaikan dengan informasi database Anda
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "uas_mobile";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);

$searchKeyword = isset($input['search']) ? $input['search'] : '';

if ($searchKeyword) {
    $sql = "SELECT * FROM transactions WHERE name LIKE '%$searchKeyword%' OR category LIKE '%$searchKeyword%'";
} else {
    $sql = "SELECT * FROM transactions";
}

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $response = array();
    while ($row = $result->fetch_assoc()) {
        $response[] = $row;
    }
    echo json_encode($response);
} else {
    echo json_encode(array("message" => "No results found"));
}

$conn->close();
?>
