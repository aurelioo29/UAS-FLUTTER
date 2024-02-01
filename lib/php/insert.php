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

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $data = json_decode(file_get_contents("php://input"));

    $name = $data->name;
    $category = $data->category;
    $satuan = $data->satuan;
    $quantity = $data->quantity;
    $total = $data->total;

    $sql = "INSERT INTO transactions (name, category, satuan, quantity, total) VALUES ('$name', '$category', '$satuan', '$quantity', '$total')";

    if ($conn->query($sql) === TRUE) {
        $response = ["status" => "success", "message" => "Data inserted successfully"];
        echo json_encode($response);
    } else {
        $response = ["status" => "error", "message" => "Error: " . $sql . "<br>" . $conn->error];
        echo json_encode($response);
    }
}

$conn->close();
?>
