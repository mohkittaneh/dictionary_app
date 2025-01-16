<?php
$servername = "localhost";
$username = "root";
$password = "12345678"; // Use the correct password
$dbname = "dictionary_app";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
echo "Connected successfully!";
?>
