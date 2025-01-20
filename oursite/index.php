<!DOCTYPE html>
<html>
<head>
    <title>Simple Dictionary</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Simple Dictionary</h1>
    <form method="POST">
        <label for="word">Enter a word:</label>
        <input type="text" id="word" name="word" required>
        <button type="submit">Search</button>
    </form>
    <?php
    // Enable error reporting
    error_reporting(E_ALL);
    ini_set('display_errors', 1);

    // Database connection
    $servername = "db";
    $username = "user";
    $password = "your_password";
    $dbname = "dictionary_app";

    $conn = new mysqli($servername, $username, $password, $dbname);

    // Check connection
    if ($conn->connect_error) {
        die("<p>Connection failed: " . $conn->connect_error . "</p>");
    }
    echo "<p>Connected successfully to the database.</p>";

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $word = strtolower(trim($_POST["word"]));

        // Query to fetch word definition
        $sql = "SELECT definition FROM words WHERE word = ?";
        $stmt = $conn->prepare($sql);
        if (!$stmt) {
            die("<p>Statement preparation failed: " . $conn->error . "</p>");
        }

        $stmt->bind_param("s", $word);
        if (!$stmt->execute()) {
            die("<p>Execution failed: " . $stmt->error . "</p>");
        }

        $result = $stmt->get_result();
        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            echo "<h2>Word: " . htmlspecialchars($word) . "</h2>";
            echo "<p>Definition: " . htmlspecialchars($row["definition"]) . "</p>";
        } else {
            echo "<h2>Word: " . htmlspecialchars($word) . "</h2>";
            echo "<p>Definition: Not found in dictionary.</p>";
        }

        $stmt->close();
    }

    $conn->close();
    ?>
</body>
</html>
