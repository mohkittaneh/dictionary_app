<?php
$servername = "db";
$username = "user";
$password = "your_password";

$conn = new mysqli($servername, $username, $password);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} else {
    echo "Database connection successful!";
}
$conn->close();
?>
