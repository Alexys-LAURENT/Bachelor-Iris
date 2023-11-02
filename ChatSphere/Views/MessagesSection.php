<?php
if (isset($idDiscussion)) {
    $discussionInfo = $unControleur->getDiscussionInfo($user['idUser'], $idDiscussion);
}
?>
<div class="lg:w-[57%] w-full overflow-hidden">
    <nav class="w-full flex h-[50px]  border-b-2">

        <div onclick="toggleConv()" class="w-[50px] flex block lg:hidden border-e-2">
            <button class="w-full flex  justify-center items-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-chat-left" viewBox="0 0 16 16">
                    <path d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H4.414A2 2 0 0 0 3 11.586l-2 2V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z" />
                </svg>
            </button>
        </div>


        <div class="flex w-full items-center ps-4 ">
            <div class="bg-cover bg-center bg-gray-700 aspect-square w-[40px] h-[40px] rounded-md <?php if (!isset($discussionInfo)) echo 'hidden' ?> " style="background-image: url('../../usersImages/<?php if (isset($discussionInfo)) echo $discussionInfo['pp']; ?>');"></div>
            <div class="flex flex-col ms-3">
                <p class=" w-full text-elipsis line-clamp-1"><?php echo $discussionInfo['nom']; ?></p>
                <span class="text-2xs <?php if (!isset($discussionInfo)) echo 'hidden' ?>">En ligne</span>
            </div>
        </div>

        <div onclick="toggleMembers()" class="w-[50px] flex block lg:hidden border-s-2">
            <button class="w-full flex  justify-center items-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-people" viewBox="0 0 16 16">
                    <path d="M15 14s1 0 1-1-1-4-5-4-5 3-5 4 1 1 1 1h8Zm-7.978-1A.261.261 0 0 1 7 12.996c.001-.264.167-1.03.76-1.72C8.312 10.629 9.282 10 11 10c1.717 0 2.687.63 3.24 1.276.593.69.758 1.457.76 1.72l-.008.002a.274.274 0 0 1-.014.002H7.022ZM11 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4Zm3-2a3 3 0 1 1-6 0 3 3 0 0 1 6 0ZM6.936 9.28a5.88 5.88 0 0 0-1.23-.247A7.35 7.35 0 0 0 5 9c-4 0-5 3-5 4 0 .667.333 1 1 1h4.216A2.238 2.238 0 0 1 5 13c0-1.01.377-2.042 1.09-2.904.243-.294.526-.569.846-.816ZM4.92 10A5.493 5.493 0 0 0 4 13H1c0-.26.164-1.03.76-1.724.545-.636 1.492-1.256 3.16-1.275ZM1.5 5.5a3 3 0 1 1 6 0 3 3 0 0 1-6 0Zm3-2a2 2 0 1 0 0 4 2 2 0 0 0 0-4Z" />
                </svg>
            </button>
        </div>
    </nav>

    <!-- content -->
    <div class="flex flex-col h-[calc(100%-150px)] py-4 relative">

        <div id="messagesDiv" class="messagesDiv overflow-y-auto">

        </div>

        <!-- button scroll to bottom -->
        <div onclick="scrollToBottom()" class="scrollToBottomButton w-[50px] h-[50px] bg-white border shadow rounded-full absolute bottom-0 right-0 mb-4 mr-4 flex justify-center items-center cursor-pointer select-none">

            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-arrow-down" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M8 3.5a.5.5 0 0 1 .5.5v6.793l2.146-2.147a.5.5 0 1 1 .708.708l-3 3a.5.5 0 0 1-.708 0l-3-3a.5.5 0 0 1 .708-.708L7.5 10.293V4a.5.5 0 0 1 .5-.5Z" />
            </svg>
        </div>

    </div>

    <!-- message textarea -->
    <div class="flex h-[100px] justify-center bg-white <?php if (!isset($discussionInfo)) echo 'hidden' ?>">
        <div class="w-[90%] h-[50px] flex items-center relative">
            <form id="message-form" class="flex w-full items-center h-[44px] border-2 border-gray-200 rounded-md ">
                <input name="" id="messageInput" class="w-full h-full p-2 resize-none rounded-md outline-none" placeholder="Ecrivez votre message ici..." maxlength="255">
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
        var scrollToBottomButton = document.getElementsByClassName("scrollToBottomButton")[0];
        if (messagesDiv.scrollHeight - messagesDiv.scrollTop - messagesDiv.clientHeight > 750) {
            scrollToBottomButton.style.display = "flex";
        } else {
            scrollToBottomButton.style.display = "none";
        }
    }

    window.onload = function() {
        toggleScrollToBottomButton();
    };

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
    var totalMess = 0;

    function displayMessages(messages) {
        var previousUser = null;
        var messagesDiv = document.getElementById("messagesDiv");
        // get profile picture with javascript message['idUser']
        messagesDiv.innerHTML = "";
        messages.forEach(message => {
            if (message['idUser'] == <?php echo $user['idUser']; ?>) {
                if (previousUser == null || previousUser != message['idUser']) {
                    messagesDiv.innerHTML += `
                        <div class='msgMe flex justify-end ${previousUser == null ? "mt-0" : "mt-8"}'>
                            <div class='flex flex-col bg-secondary text-white max-w-[80%] rounded-md p-2 mx-2 min-w-[75px]'>
                                <div>${ message['content'] }</div>
                                <div class='w-full flex justify-end items-center'>
                                    <span class='text-2xs'>${message['timestamp'].substring(16,5) }</span>
                                </div>
                            </div>
                            <div class='bg-cover bg-center bg-gray-700 aspect-square w-[40px] h-[40px] rounded-md mx-2 ms-0' style='background-image: url("../../usersImages/${message['pp']}");'
                            ></div>
                        </div>
                        `;
                } else {
                    // messages après la photo de profil
                    messagesDiv.innerHTML += `
                        <div class='msgMe flex justify-end mt-1'>
                            <div class='flex flex-col bg-secondary text-white max-w-[80%] rounded-md p-2 mx-2 min-w-[75px]' >
                                <div>${message['content'] }</div>
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
                        <div class='msgOthers flex justify-start ${previousUser == null ? "mt-0" : "mt-8"}'>
                            <div class='bg-cover bg-center bg-gray-700 aspect-square w-[40px] h-[40px] rounded-md mx-2 me-0' style='background-image: url("../../usersImages/${message['pp']}");'></div>
                            <div class='flex flex-col bg-userMessage text-black max-w-[80%] rounded-md p-2 mx-2 min-w-[75px]'>
                                <div>${message['content'] }</div>
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
                                <div>${message['content'] }</div>
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
        if (totalMess != messages.length) {
            setTimeout(function() {
                scrollToBottom();
            }, 1500);
        }
        totalMess = messages.length;
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
                    displayMessages(data);
                }
            };
            xhr.send();
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
            }
        }, 500); // toutes les 500ms

        // Gérer l'envoi de messages avec l'ID de discussion
        var messageForm = document.getElementById("message-form");
        messageForm.addEventListener("submit", function(event) {
            event.preventDefault();
            var messageInput = document.getElementById("messageInput");
            var message = messageInput.value;

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "send_message.php", true);
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var isSend = JSON.parse(xhr.responseText);
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
</script>