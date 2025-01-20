<?php
$servername = "db";
$username = "root";
$password = "123";

$conn = new mysqli($servername, $username, $password);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $input_word = $conn->real_escape_string($_POST['input_word']);
    $sql = "SELECT matched_word FROM mydb.words WHERE input_word = '$input_word'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $matched_word = $row['matched_word'];
        echo json_encode(['success' => true, 'matched_word' => $matched_word]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Word not found']);
    }
}

$conn->close();
?>