<?php
$discussions = $unControleur->getDiscussionsDetails($user['idUser']);
$colleagues = $unControleur->getAllColleagues($user['idUser']);
if (isset($_POST['createDiscussion'])) {
    $discussionName = $_POST['NewDiscussionName'] == "" ? null : $_POST['NewDiscussionName'];
    $createDiscussion = $unControleur->createDiscussion($discussionName, array_merge($_POST['members'], array($user['idUser'])), $user['idUser']);
    // create or replace get parameter discussion
    header('Location: ?token=' . $_GET['token'] . '&discussion=' . $createDiscussion);
}
?>
<div id="convSection" class="lg:w-[23%] w-0 left-0 max-w-[100%]  h-screen absolute lg:relative lg:block lg:bg-white bg-gray-50 overflow-hidden transition-all duration-500 border-e-2 dark:border-gray-800 z-10 dark:bg-dark dark:text-white">
    <div class="h-[50px] flex justify-between items-center p-4 border-b-2 dark:border-gray-800 transition-all duration-500">

        <div class="flex items-center">
            <p id="countDiscussions" class="flex transition-all duration-500 text-black dark:text-white gap-2 items-center">Discussions <span class="flex items-center text-black justify-center font-semibold text-sm w-7 h-7 rounded-full bg-gray-200"><?php echo count($discussions); ?></span></p>
        </div>
        <div class="flex gap-2 items-center">

            <button class="bg-secondary w-7 h-7 rounded-full flex justify-center items-center ">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M12 4v16m8-8H4" />
                </svg>
            </button>

            <!-- close drawer btn -->
            <div class="block lg:hidden ms-2">
                <svg onclick="toggleConv()" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
                    <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z" />
                </svg>
            </div>
        </div>

        <?php require_once('popUpCreateDiscussion.php'); ?>

    </div>

    <div class="flex justify-center ">
        <!-- content -->


        <div class="flex flex-col items-center gap-1 relative w-full">
            <div class="flex w-full justify-between w-full my-3 h-[30px] px-4">
                <input id="searchInput" type="text" placeholder="Rechercher" class="rounded-md bg-userMessage dark:bg-darkHover px-2 py-1 w-full focus:outline-primary dark:focus:outline-black cursor-text text-gray-600 dark:text-gray-400 transition-all duration-500">

            </div>

            <div id="discussionsWrapper" class="w-full flex flex-col gap-2 overflow-y-auto h-[calc(100vh-180px)]
            ">

            </div>

            <div class="flex gap-2 w-full h-[68px] border-t-2 dark:border-gray-800 items-center px-3 justify-between transition-all duration-500">
                <div class="flex gap-2">
                    <div class="bg-cover bg-center aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]" style="background-image: url(https://images.chatsphere.alexyslaurent.com/<?php echo $user['pp']; ?>);"></div>
                    <div class="flex flex-col w-full">
                        <p class="font-semibold w-full text-elipsis line-clamp-1 transition-all duration-500 text-black dark:text-white"><?php echo $user['prenom'] . ' ' . $user['nom']; ?></p>

                        <div class="flex relative">
                            <!-- popup statut -->
                            <div id="statutPopup" class="hidden absolute bottom-[25px] w-[150px] border border-gray-200 rounded-md shadow-md z-10 bg-white dark:bg-dark text-gray-500 dark:text-gray-300 transition-all duration-500">
                                <div onclick="ChangeStatut('En ligne')" class="flex items-center gap-1 hover:cursor-pointer hover:bg-hover rounded-md px-2 py-1 dark:hover:text-black">
                                    <div class="w-2 h-2 rounded-full bg-green-500">
                                    </div>
                                    <p class="text-xs">En ligne</p>
                                </div>
                                <div onclick="ChangeStatut('Absent')" class="flex items-center gap-1 hover:cursor-pointer hover:bg-hover rounded-md px-2 py-1 dark:hover:text-black">
                                    <div class="w-2 h-2 rounded-full bg-yellow-500">
                                    </div>
                                    <p class="text-xs">Absent</p>
                                </div>
                                <div onclick="ChangeStatut('Occupé')" class="flex items-center gap-1 hover:cursor-pointer hover:bg-hover rounded-md px-2 py-1 dark:hover:text-black">
                                    <div class="w-2 h-2 rounded-full bg-red-500">
                                    </div>
                                    <p class="text-xs">Occupé</p>
                                </div>
                                <div onclick="ChangeStatut('Hors ligne')" class="flex items-center gap-1 hover:cursor-pointer hover:bg-hover rounded-md px-2 py-1 dark:hover:text-black">
                                    <div class="w-2 h-2 rounded-full bg-gray-500">
                                    </div>
                                    <p class="text-xs">Hors ligne</p>
                                </div>
                            </div>

                            <div id="userLoggedStatusWrapper" onclick="toggleStatut()" class="flex items-center gap-1 hover:cursor-pointer hover:bg-hover rounded-md px-2 py-1 text-gray-500 dark:text-gray-300 dark:hover:text-black hidden transition-all duration-500">
                                <div id="userLogedStatusColor" class="w-2 h-2 rounded-full"></div>
                                <p id="userLogedStatusText" class="text-xs"></p>
                                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="mt-[0.15rem] bi bi-chevron-up" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z" />
                                </svg>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="">
                    <div onclick="toggleThemeMode()" class="hover:cursor-pointer">
                        <svg id="moonSvg" class="hidden" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="white" class="bi bi-moon-fill" viewBox="0 0 16 16">
                            <path d="M6 .278a.768.768 0 0 1 .08.858 7.208 7.208 0 0 0-.878 3.46c0 4.021 3.278 7.277 7.318 7.277.527 0 1.04-.055 1.533-.16a.787.787 0 0 1 .81.316.733.733 0 0 1-.031.893A8.349 8.349 0 0 1 8.344 16C3.734 16 0 12.286 0 7.71 0 4.266 2.114 1.312 5.124.06A.752.752 0 0 1 6 .278z" />
                        </svg>

                        <svg id="sunSvg" class="hidden" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="black" class="bi bi-sun-fill" viewBox="0 0 16 16">
                            <path d="M8 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z" />
                        </svg>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>


<script>
    if (document.getElementsByTagName('html')[0].classList.contains('dark')) {
        document.getElementById('moonSvg').classList.remove('hidden');
        document.getElementById('sunSvg').classList.add('hidden');
    } else {
        document.getElementById('moonSvg').classList.add('hidden');
        document.getElementById('sunSvg').classList.remove('hidden');
    }

    function toggleThemeMode() {
        toggleThemeModeInBdd();
        document.getElementsByTagName('html')[0].classList.toggle('dark');
        document.getElementsByTagName('html')[0].classList.toggle('white');
        if (document.getElementsByTagName('html')[0].classList.contains('dark')) {
            document.getElementById('moonSvg').classList.remove('hidden');
            document.getElementById('sunSvg').classList.add('hidden');
        } else {
            document.getElementById('moonSvg').classList.add('hidden');
            document.getElementById('sunSvg').classList.remove('hidden');
        }
    }

    function toggleThemeModeInBdd() {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "update_themeMode.php", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.send("themeMode=" + (document.getElementsByTagName('html')[0].classList.contains('dark') ? "white" : "dark") + "&idUser=" + <?php echo $user['idUser']; ?>);
    }

    // Fonction pour filtrer les messages
    function filterMessages() {
        // Récupérer la valeur de l'entrée de recherche
        const searchInput = document.getElementById("searchInput");
        const searchText = searchInput.value.toLowerCase();

        // Sélectionner tous les messages à filtrer (les spans contenant les messages)
        const messageSpans = document.querySelectorAll(".conversationRow");

        // Parcourir tous les messages et les afficher ou les masquer en fonction de la recherche
        messageSpans.forEach(span => {
            const messageText = span.textContent.toLowerCase();
            if (messageText.includes(searchText)) {
                span.parentElement.parentElement.parentElement.style.display = "flex"; // Afficher le message
            } else {
                span.parentElement.parentElement.parentElement.style.display = "none"; // Masquer le message
            }
        });
    }

    // Écouter les événements de changement dans l'entrée de recherche
    const searchInput = document.getElementById("searchInput");
    searchInput.addEventListener("input", filterMessages);

    function toggleStatut() {
        document.getElementById('statutPopup').classList.toggle('hidden');
    }

    var userLogedStatus = null;

    function displayUserLogedStatus(data) {
        document.getElementById('userLogedStatusColor').classList.remove('bg-green-500');
        document.getElementById('userLogedStatusColor').classList.remove('bg-yellow-500');
        document.getElementById('userLogedStatusColor').classList.remove('bg-red-500');
        document.getElementById('userLogedStatusColor').classList.remove('bg-gray-500');
        userLogedStatus = data.statut;
        switch (data.statut) {
            case "En ligne":
                document.getElementById('userLogedStatusColor').classList.add('bg-green-500');
                document.getElementById('userLogedStatusText').innerHTML = "En ligne";
                break;
            case "Absent":
                document.getElementById('userLogedStatusColor').classList.add('bg-yellow-500');
                document.getElementById('userLogedStatusText').innerHTML = "Absent";
                break;
            case "Occupé":
                document.getElementById('userLogedStatusColor').classList.add('bg-red-500');
                document.getElementById('userLogedStatusText').innerHTML = "Occupé";
                break;
            case "Hors ligne":
                document.getElementById('userLogedStatusColor').classList.add('bg-gray-500');
                document.getElementById('userLogedStatusText').innerHTML = "Hors ligne";
                break;
        }
        document.getElementById('userLoggedStatusWrapper').classList.remove('hidden');
    }

    function ChangeStatut(newStatus) {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "update_userLogedStatus.php", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            document.getElementById('statutPopup').classList.toggle('hidden');
        };
        xhr.send("status=" + newStatus + "&idUser=" + <?php echo $user['idUser']; ?>);
    }

    document.addEventListener("DOMContentLoaded", function() {
        // Fonction pour récupérer les messages d'une discussion spécifique
        function getUserLogedStatus(idUser) {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "get_userStatus.php?idUser=" + idUser, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var data = JSON.parse(xhr.responseText);
                    displayUserLogedStatus(data);
                }
            };
            xhr.send();
        }


        // Appeler la fonction getMessages avec l'ID de discussion spécifique
        const idUser = <?php echo $user['idUser']; ?>;

        setInterval(function() {
            if (idUser != null) {
                getUserLogedStatus(idUser);
            }
        }, 1000); // toutes les secondes
    });

    var allDiscussions = []

    function getDiscussions(haveToSendNotifications) {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "get_discussionsDetails.php?idUser=" + <?php echo $user['idUser']; ?>, true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var data = JSON.parse(xhr.responseText);
                displayDiscussions(data, haveToSendNotifications);
            }
        };
        xhr.send();
    }

    function displayDiscussions(data, haveToSendNotifications) {
        document.getElementById('discussionsWrapper').innerHTML = "";
        data.forEach(discussion => {
            var classDiscussion = <?php echo isset($_GET['discussion']) ? $_GET['discussion'] : 'null'; ?>;
            var classDiscussion = classDiscussion == discussion.idDiscussion ? 'bg-hover dark:bg-darkHover transition-all duration-500' : '';
            var spanClass = discussion.isMessageRead === false ? "dark:text-white text-black font-bold text-sm" : "text-gray-500 text-xs";
            document.getElementById('discussionsWrapper').innerHTML += `
            <a href='?token=<?php echo $_GET['token']; ?>&discussion=${discussion.idDiscussion}' class='px-2 p-0 w-full'>
            <div class='w-full flex flex-col gap-2 hover:bg-hover dark:hover:bg-darkHover hover:cursor-pointer rounded-md py-2 ${classDiscussion}'>
            <!-- Contact row -->
            <div class='flex max-w-full mx-3 gap-2'>
            <div class='z-0 bg-cover bg-center aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]' style='${discussion.pp != 'default.webp' ? "background-image: url(https://images.chatsphere.alexyslaurent.com/" + discussion.pp + ")" : "background-color: #" + discussion.color}'>
            <span class='flex text-2xl w-full text-white h-full justify-center items-center ${discussion.pp != 'default.webp' ? 'hidden' : ''}'>${discussion.nom.substr(0, 1) + (discussion.nom.indexOf(' ') != -1 ? discussion.nom.substr(discussion.nom.indexOf(' ') + 1, 1) : '')}</span>
            </div>
            <div class='flex flex-col transition-all duration-500 text-black dark:text-white'>
            <p class='font-semibold w-full text-elipsis line-clamp-1'>${discussion.nom}</p>
            <span class=' conversationRow w-full max-w-full line-clamp-1 text-elipsis ${spanClass} relative top-[-3px] text-elipsis line-clamp-1'>${discussion.dernier_message != null ? discussion.dernier_message : ''}</span>
            </div>
            </div>
            </div>
            </a>`;
        });

        if (haveToSendNotifications === true) {
            // keep only the diff between allDiscussions and data

            var diffDiscussions = data.filter(function(obj) {
                return !allDiscussions.some(function(obj2) {
                    return obj.dernier_message == obj2.dernier_message;
                });
            });
            sendNotifications(diffDiscussions);
        }

        allDiscussions = data;
    }

    function sendNotifications(messageToNotify) {
        if (messageToNotify.length == 0) return;
        messageToNotify.forEach(message => {
            if (Notification.permission === "granted" && message.isMessageRead === false && userLogedStatus != "Hors ligne" && userLogedStatus != "Occupé") {
                var notification = new Notification('Nouveau message - ' + message.nom, {
                    body: message.dernier_message,
                    icon: 'https://images.chatsphere.alexyslaurent.com/' + message.pp + '',
                });
            }
        });
    }

    getDiscussions(false);

    setInterval(function() {
        getDiscussions(true);
    }, 1000); // toutes les secondes
</script>

</aside>