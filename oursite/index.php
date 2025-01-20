<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dictionary Application</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    
    <div class="container mt-5">
        <h1 class="text-center">Simple  Application</h1>
        <form id="dictionary-form" class="mt-4">
            <div class="mb-3">
                <label for="input-word" class="form-label">Enter a word:</label>
                <input type="text" id="input-word" name="input_word" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Find Matched Word</button>
        </form>
        <div id="result" class="mt-4"></div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $("#dictionary-form").on("submit", function (e) {
            e.preventDefault();

            const inputWord = $("#input-word").val();
            $.post("connect.php", { input_word: inputWord }, function (response) {
                const data = JSON.parse(response);
                if (data.success) {
                    $("#result").html(`<div class="alert alert-success">Matched Word: ${data.matched_word}</div>`);
                } else {
                    $("#result").html(`<div class="alert alert-danger">${data.message}</div>`);
                }
            });
        });
    </script>



</body>
</html>