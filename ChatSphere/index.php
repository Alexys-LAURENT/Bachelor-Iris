<?php
require_once("Controller/config_bdd.php");
require_once("Controller/controller.class.php");
$unControleur = new Controleur($serveur, $bdd, $user, $mdp);

$token = $_GET['token'];
$user = $unControleur->checkToken($token);
if ($user == false) {
    header("Location: login.php");
}

if (isset($_GET['discussion']) && $unControleur->checkIdDiscussion($_GET['discussion'], $user['idUser']) == true) {
    $idDiscussion = $_GET['discussion'];
}
?>
<!DOCTYPE html>
<html lang="en" class="<?php echo $user['theme'] ?> select-none">

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
                        darkHover: "#171D27",
                        userMessage: "#F1F1F1",
                        border: "#E2E8F0",
                        dark: "#0d1117"
                    },
                },
            },
            darkMode: "class",
        }
    </script>
    <script src="./js/index.js?"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.2.0/crypto-js.min.js" integrity="sha512-a+SUDuwNzXDvz4XrIcXHuCf089/iJAoN4lmrXJg18XnduKK6YlDHNRalv4yd1N40OKI80tFidF+rqTFKGPoWFQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="./css/index.css?">
    <link rel="shortcut icon" href="./images/Message-icon.svg" type="image/x-icon">
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

<script>
    Notification.requestPermission();
</script>

</html>