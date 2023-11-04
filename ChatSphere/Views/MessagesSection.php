<?php
if (isset($idDiscussion)) {
    $discussionInfo = $unControleur->getDiscussionInfo($user['idUser'], $idDiscussion);
}
?>

<div class="lg:w-[57%] w-full overflow-hidden dark:bg-dark transition-all duration-500">
    <nav class="w-full flex h-[50px] border-b-2 dark:text-white">

        <div onclick="toggleConv()" class="min-w-[50px] flex block lg:hidden border-e-2">
            <button class="w-full flex  justify-center items-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-chat-left" viewBox="0 0 16 16">
                    <path d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H4.414A2 2 0 0 0 3 11.586l-2 2V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z" />
                </svg>
            </button>
        </div>


        <div class="flex w-full items-center ps-4 ">
            <div class="bg-cover bg-center bg-gray-700 aspect-square w-[40px] h-[40px] rounded-md <?php if (!isset($discussionInfo)) echo 'hidden' ?> " style="background-image: url('http://images.foda4953.odns.fr/<?php if (isset($discussionInfo)) echo $discussionInfo['pp']; ?>');"></div>
            <div class="flex flex-col ms-3">
                <p class=" w-full text-elipsis line-clamp-1"><?php if (isset($discussionInfo)) echo $discussionInfo['nom']; ?></p>
                <div class="flex items-center gap-2">
                    <div id="userConvStatusColor" class="w-2 h-2 rounded-full <?php if (!isset($discussionInfo['idUser'])) echo "hidden"; ?> "></div>
                    <span id="userConvStatusText" class="text-2xs <?php if (!isset($discussionInfo)) echo 'hidden' ?> <?php if (!isset($discussionInfo['idUser'])) echo "hidden"; ?>"></span>
                </div>
            </div>
        </div>

        <div onclick="toggleStats()" class="min-w-[50px] flex">
            <button class="w-full flex  justify-center items-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-bar-chart-line" viewBox="0 0 16 16">
                    <path d="M11 2a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v12h.5a.5.5 0 0 1 0 1H.5a.5.5 0 0 1 0-1H1v-3a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3h1V7a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v7h1V2zm1 12h2V2h-2v12zm-3 0V7H7v7h2zm-5 0v-3H2v3h2z" />
                </svg>
            </button>
        </div>

        <div onclick="toggleMembers()" class="min-w-[50px] flex block lg:hidden border-s-2">
            <button class="w-full flex  justify-center items-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-people" viewBox="0 0 16 16">
                    <path d="M15 14s1 0 1-1-1-4-5-4-5 3-5 4 1 1 1 1h8Zm-7.978-1A.261.261 0 0 1 7 12.996c.001-.264.167-1.03.76-1.72C8.312 10.629 9.282 10 11 10c1.717 0 2.687.63 3.24 1.276.593.69.758 1.457.76 1.72l-.008.002a.274.274 0 0 1-.014.002H7.022ZM11 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4Zm3-2a3 3 0 1 1-6 0 3 3 0 0 1 6 0ZM6.936 9.28a5.88 5.88 0 0 0-1.23-.247A7.35 7.35 0 0 0 5 9c-4 0-5 3-5 4 0 .667.333 1 1 1h4.216A2.238 2.238 0 0 1 5 13c0-1.01.377-2.042 1.09-2.904.243-.294.526-.569.846-.816ZM4.92 10A5.493 5.493 0 0 0 4 13H1c0-.26.164-1.03.76-1.724.545-.636 1.492-1.256 3.16-1.275ZM1.5 5.5a3 3 0 1 1 6 0 3 3 0 0 1-6 0Zm3-2a2 2 0 1 0 0 4 2 2 0 0 0 0-4Z" />
                </svg>
            </button>
        </div>
    </nav>

    <?php
    require_once("./Views/Statistiques.php");
    ?>

    <!-- content Messages -->
    <div class="flex flex-col h-[calc(100%-150px)] py-4 relative" id="MessagesWrapper">

        <div id="messagesDiv" class="messagesDiv overflow-y-auto select-text">

        </div>

        <!-- button scroll to bottom -->
        <div id="scrollToBottomButton" onclick="scrollToBottom()" class="scrollToBottomButton w-[50px] h-[50px] bg-white border shadow rounded-full absolute bottom-0 right-0 mb-4 me-2 flex justify-center items-center cursor-pointer select-none hidden">
            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="black" class="bi bi-arrow-down" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M8 3.5a.5.5 0 0 1 .5.5v6.793l2.146-2.147a.5.5 0 1 1 .708.708l-3 3a.5.5 0 0 1-.708 0l-3-3a.5.5 0 0 1 .708-.708L7.5 10.293V4a.5.5 0 0 1 .5-.5Z" />
            </svg>
        </div>

    </div>

    <!-- message textarea -->
    <div class="flex h-[100px] justify-center bg-white dark:bg-dark transition-all duration-500 <?php if (!isset($discussionInfo)) echo 'hidden' ?>" id="MessageInputWrapper">
        <div class="w-[90%] h-[50px] flex items-center relative">
            <form autocomplete="off" id="message-form" class="flex w-full items-center h-[44px] border-2 border-gray-200 rounded-md bg-white">
                <input id="messageInput" class="w-full h-full p-2 resize-none rounded-md outline-none" placeholder="Ecrivez votre message ici..." maxlength="255">
                <button type="submit">
                    <img src="./Assets/sendMessageButton.png" alt="" class="cursor-pointer h-[50px] w-[50px]">
                </button>
                <!-- character counter -->
                <div class="absolute -bottom-6 right-0 mr-2 text-2xs text-gray-400"><span id="characterCounter">0</span>/255</div>
            </form>
        </div>
    </div>
</div>


<script type="text/javascript">
    // scroll to bottom

    // scroll to bottom on load
    setTimeout(function() {
        scrollToBottom();
    }, 1500);

    function scrollToBottom() {
        var objDiv = document.getElementsByClassName("messagesDiv")[0];
        objDiv.lastElementChild.scrollIntoView({
            behavior: "smooth"
        });
    }

    function toggleScrollToBottomButton() {
        var messagesDiv = document.getElementsByClassName("messagesDiv")[0];
        var scrollToBottomButton = document.getElementById("scrollToBottomButton");
        if (messagesDiv.scrollHeight - messagesDiv.scrollTop - messagesDiv.clientHeight > 750) {
            scrollToBottomButton.classList.remove("hidden");
        } else {
            scrollToBottomButton.classList.add("hidden");
        }
    }

    document.getElementsByClassName("messagesDiv")[0].addEventListener("scroll", function() {
        toggleScrollToBottomButton();
    });



    // character counter

    var textarea = document.getElementById("messageInput");
    var counter = document.getElementById("characterCounter");

    textarea.addEventListener("input", function() {
        counter.innerHTML = textarea.value.length;
    });

    // AJAX //////////////////////////////////////////////////////
    var totalMess = [];

    function displayMessages(messages) {
        var previousUser = null;
        var messagesDiv = document.getElementById("messagesDiv");
        // isGroup = if distinct idUser in messages is > 2
        var isGroup = new Set(messages.map(message => message.idUser)).size > 2;
        messagesDiv.innerHTML = "";
        messages.forEach(message => {
            if (message['idUser'] == <?php echo $user['idUser']; ?>) {
                if (previousUser == null || previousUser != message['idUser']) {
                    messagesDiv.innerHTML += `
                        <div class='msgMe flex justify-end ${previousUser == null ? "mt-0" : "mt-8"}'>
                            <div class='flex flex-col bg-secondary text-white max-w-[80%] rounded-md p-2 mx-2 min-w-[75px]'>
                                <div class="break-words">${ message['content'] }</div>
                                <div class='w-full flex justify-end items-center'>
                                    <span class='text-2xs'>${message['timestamp'].substring(16,5) }</span>
                                </div>
                            </div>
                            <div class='bg-cover bg-center bg-gray-700 aspect-square w-[40px] h-[40px] rounded-md mx-2 ms-0' style='background-image: url("http://images.foda4953.odns.fr/${message['pp']}");'
                            ></div>
                        </div>
                        `;
                } else {
                    // messages après la photo de profil
                    messagesDiv.innerHTML += `
                        <div class='msgMe flex justify-end mt-1'>
                            <div class='flex flex-col bg-secondary text-white max-w-[80%] rounded-md p-2 mx-2 min-w-[75px]' >
                                <div class="break-words">${message['content'] }</div>
                                <div class='w-full flex justify-end items-center'>
                                    <span class='text-2xs'>${message['timestamp'].substring(16,5) }</span>
                                </div>
                            </div>
                            <div class='w-[40px] h-[40px] m-2 ms-0'></div>
                        </div>
                        `;
                }
            } else {
                if (previousUser == null || previousUser != message['idUser']) {
                    messagesDiv.innerHTML += `
                    ${isGroup ? `
                    <div class='dark:text-white text-start ms-14 ${previousUser == null ? "mt-0" : "mt-8"}'>${message['prenom']} ${message['nom']}</div>
                    ` : ``}
                        <div class='msgOthers flex justify-start'>
                            <div class='bg-cover bg-center bg-gray-700 aspect-square w-[40px] h-[40px] rounded-md mx-2 me-0' style='background-image: url("http://images.foda4953.odns.fr/${message['pp']}");'></div>
                            <div class='flex flex-col bg-userMessage text-black max-w-[80%] rounded-md p-2 mx-2 min-w-[75px]'>
                                <div class="break-words">${message['content'] }</div>
                                <div class='w-full flex justify-end items-center'>
                                    <span class='text-2xs'>${message['timestamp'].substring(16,5) }</span>
                                </div>
                            </div>
                        </div>
                        `;
                } else {
                    // messages après la photo de profil
                    messagesDiv.innerHTML += `
                        <div class='msgOthers flex justify-start mt-1'>
                            <div class='w-[40px] h-[40px] m-2 ms-0'></div>
                            <div class='flex flex-col bg-userMessage text-black max-w-[80%] rounded-md p-2 mx-2 min-w-[75px]'>
                                <div class="break-words">${message['content'] }</div>
                                <div class='w-full flex justify-end items-center'>
                                    <span class='text-2xs'>${message['timestamp'].substring(16,5)}</span>
                                </div>
                            </div>
                        </div>
                        `;
                }
            }
            previousUser = message['idUser'];
        });
        if (totalMess.length != messages.length && (messagesDiv.scrollHeight - messagesDiv.scrollTop - messagesDiv.clientHeight > 750)) {
            document.getElementById('scrollToBottomButton').classList.remove("hidden");
        }
        totalMess = messages;
    }

    function displayUserConvStatus(data) {
        document.getElementById('userConvStatusColor').classList.remove('bg-green-500');
        document.getElementById('userConvStatusColor').classList.remove('bg-yellow-500');
        document.getElementById('userConvStatusColor').classList.remove('bg-red-500');
        document.getElementById('userConvStatusColor').classList.remove('bg-gray-500');
        switch (data.statut) {
            case "En ligne":
                document.getElementById('userConvStatusColor').classList.add('bg-green-500');
                document.getElementById('userConvStatusText').innerHTML = "En ligne";
                break;
            case "Absent":
                document.getElementById('userConvStatusColor').classList.add('bg-yellow-500');
                document.getElementById('userConvStatusText').innerHTML = "Absent";
                break;
            case "Occupé":
                document.getElementById('userConvStatusColor').classList.add('bg-red-500');
                document.getElementById('userConvStatusText').innerHTML = "Occupé";
                break;
            case "Hors ligne":
                document.getElementById('userConvStatusColor').classList.add('bg-gray-500');
                document.getElementById('userConvStatusText').innerHTML = "Hors ligne";
                break;
        }
    }

    document.addEventListener("DOMContentLoaded", function() {
        // Fonction pour récupérer les messages d'une discussion spécifique
        function getMessages(idDiscussion) {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "get_messages.php?idDiscussion=" + idDiscussion, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var data = JSON.parse(xhr.responseText);
                    // Mettre à jour la vue avec les nouveaux messages
                    // data contient les messages récupérés depuis le serveur
                    if (data.length != totalMess.length) {
                        displayMessages(data);
                    }
                }
            };
            xhr.send();
        }

        function getDiscussionUserStatus(idUser) {
            if (idUser != undefined) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "get_userStatus.php?idUser=" + idUser, true);
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        var data = JSON.parse(xhr.responseText);
                        displayUserConvStatus(data);
                    }
                };
                xhr.send();
            }
        }


        // Appeler la fonction getMessages avec l'ID de discussion spécifique
        const queryString = window.location.search;
        const urlParams = new URLSearchParams(queryString);
        var idDiscussion = urlParams.get('discussion');
        var isValidIdDiscussion = <?php if (isset($idDiscussion)) echo "true";
                                    else echo "false"; ?>;
        setInterval(function() {
            if (idDiscussion != null && isValidIdDiscussion == true) {
                getMessages(idDiscussion);
                getDiscussionUserStatus(<?php if (isset($discussionInfo['idUser'])) echo $discussionInfo['idUser']; ?>);
            }
        }, 1000); // toutes les secondes

        // Gérer l'envoi de messages avec l'ID de discussion
        var messageForm = document.getElementById("message-form");
        messageForm.addEventListener("submit", function(event) {
            event.preventDefault();
            var messageInput = document.getElementById("messageInput");
            var message = messageInput.value;

            if (message.length == 0) return;
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "send_message.php", true);
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var isSend = JSON.parse(xhr.responseText);
                    document.getElementById("characterCounter").innerHTML = "0";
                    if (isSend === false) {
                        alert("Erreur lors de l'envoi du message");
                    } else {
                        setTimeout(function() {
                            document.getElementsByClassName("messagesDiv")[0].lastElementChild.scrollIntoView({
                                behavior: "smooth"
                            });
                        }, 1000);
                    }
                    // Effacer le champ de saisie ou effectuer d'autres actions
                    messageInput.value = "";
                }
            };
            xhr.send("message=" + encodeURIComponent(message) + "&idDiscussion=" + idDiscussion + "&idUser=" + <?php echo $user['idUser']; ?>);
        });
    });

    // Charts
    const totalMessChart = document.getElementById('totalMessChart');

    new Chart(totalMessChart, {
        type: 'bar',
        data: {
            labels: <?php echo json_encode($allUsersFromTotalMessStats); ?>,
            datasets: [{
                label: 'Nombre de messages total',
                data: <?php echo json_encode($allTotalsFromTotalMessStats); ?>,
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    // only show full numbers
                    ticks: {
                        callback: function(value, index, values) {
                            if (Math.floor(value) === value) {
                                return value;
                            }
                        }
                    }
                }
            },
            maintainAspectRatio: false,
        }
    });

    const totalMessByMonthByUsersChart = document.getElementById('messByMonthsChart');

    new Chart(totalMessByMonthByUsersChart, {
        type: 'line',
        data: <?php echo json_encode($chartData, JSON_NUMERIC_CHECK); ?>,
        options: {
            scales: {
                x: {
                    beginAtZero: true
                },
                y: {
                    beginAtZero: true,
                    // only show full numbers
                    ticks: {
                        callback: function(value, index, values) {
                            if (Math.floor(value) === value) {
                                return value;
                            }
                        }
                    }
                }
            },
            maintainAspectRatio: false,
        }
    });

    // toggle sections
    function toggleStats() {
        var statsWrapper = document.getElementById("StatsWrapper");
        var messagesWrapper = document.getElementById("MessagesWrapper");
        var messageInputWrapper = document.getElementById("MessageInputWrapper");

        if (statsWrapper.classList.contains("hidden")) {
            statsWrapper.classList.remove("hidden");
            statsWrapper.classList.add("flex");
            messagesWrapper.classList.add("hidden");
            messageInputWrapper.classList.add("hidden");
        } else {
            statsWrapper.classList.add("hidden");
            messagesWrapper.classList.remove("hidden");
            messageInputWrapper.classList.remove("hidden");
            messagesWrapper.classList.add("flex");
            messageInputWrapper.classList.add("flex");
        }
    }
</script>