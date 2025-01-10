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
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // MySQL connection settings
        $servername = "localhost";
        $username = "root"; // Replace with your MySQL username
        $password = ""; // Replace with your MySQL password
        $dbname = "dictionary_app";

        // Get the user input
        $word = strtolower(trim($_POST["word"]));

        // Create connection
        $conn = new mysqli($servername, $username, $password, $dbname);

        // Check connection
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }

        // Query the database
        $sql = "SELECT meaning FROM dictionary WHERE word = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("s", $word);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            echo "<h2>Word: " . htmlspecialchars($word) . "</h2>";
            echo "<p>Meaning: " . htmlspecialchars($row["meaning"]) . "</p>";
        } else {
            echo "<h2>Word: " . htmlspecialchars($word) . "</h2>";
            echo "<p>Meaning: Not found in the dictionary.</p>";
        }

        // Close connection
        $stmt->close();
        $conn->close();
    }
    ?>
</body>
</html>
