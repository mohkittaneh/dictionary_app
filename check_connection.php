<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

$servername = "abokittaneh";
$username = "berlin";
$password = "12345678"; // Replace with your MySQL password if set
$dbname = "dictionary_app";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
echo "Connected successfully!";
?>


