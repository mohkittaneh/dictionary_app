<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$servername = "db"; // Use "127.0.0.1" or "localhost" if not using Docker
$username = "root";
$password = "your_password";
$dbname = "mydb"; // Specify the database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(['success' => false, 'message' => "Database connection failed: " . $conn->connect_error]));
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $input_word = $_POST['input_word'] ?? '';

    // Use prepared statements to prevent SQL injection
    $stmt = $conn->prepare("SELECT matched_word FROM words WHERE input_word = ?");
    $stmt->bind_param("s", $input_word);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $matched_word = $row['matched_word'];
        echo json_encode(['success' => true, 'matched_word' => $matched_word]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Word not found']);
    }

    $stmt->close();
}

$conn->close();
?>

