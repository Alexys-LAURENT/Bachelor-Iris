<?php
require_once("Controller/config_bdd.php");
require_once("Controller/controller.class.php");
$unControleur = new Controleur($serveur, $bdd, $user, $mdp);

$token = $_GET['token'];
$user = $unControleur->checkToken($token);
if ($user == false) {
    header("Location: login.php");
}

?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ChatSphere</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: "#FFFFFF",
                        secondary: "#5B6CF9",
                        hover: "#EFF1FF",
                        userMessage: "#F1F1F1",
                        border: "#E2E8F0",
                    },
                },
            },
        }
    </script>
    <script src="./js/index.js"></script>
    <link rel="stylesheet" href="./css/index.css">
</head>

<body class="overflow-hidden">
    <div class="flex w-screen h-screen overflow-x-hidden">
        <?php
        require_once("Views/ConversationsSection.php");
        require_once("Views/MessagesSection.php");
        require_once("Views/MembersSection.php");
        ?>
    </div>
</body>

</html>