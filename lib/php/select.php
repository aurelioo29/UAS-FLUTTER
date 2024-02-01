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

$sql = "SELECT * FROM transactions";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
  $data = array();

  while ($row = $result->fetch_assoc()) {
      $data[] = $row;
  }

  echo json_encode($data);
} else {
  echo json_encode(array()); // Jika tidak ada data, kirimkan JSON kosong
}

$conn->close();
?>
