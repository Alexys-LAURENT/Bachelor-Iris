<?php
$discussions = $unControleur->getDiscussionsDetails($user['idUser']);
$colleagues = $unControleur->getAllColleagues($user['idUser']);
?>
<aside id="convSection" class="lg:w-[23%] w-0 left-0 max-w-[100%]  h-screen absolute lg:relative lg:block lg:bg-white bg-gray-50 overflow-hidden transition-all duration-500 border-e-2">
    <div class="h-[50px] flex justify-between items-center p-4 border-b-2">

        <div class="flex items-center">
            <p>Messages</p>
            <input type="text" value="4" class="bg-border w-5 h-5 rounded-full text-center">
        </div>
        <button onclick="ajoutermembre()" class="bg-secondary w-7 h-7 rounded-full flex justify-center items-center ">
            <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M12 4v16m8-8H4" />
            </svg>
            <!-- close drawer btn -->
            <div class="block lg:hidden  ">
                <svg onclick="toggleConv()" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
                    <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z" />
                </svg>
            </div>
    </div>

    <div class="flex justify-center ">
        <!-- content -->
        <div>

            <div class="flex flex-col items-center gap-4 relative">
                <div class="flex w-14/14 mt-3 justify-between">
                    <input id="searchInput" type="text" placeholder="Rechercher un message" class="rounded-md bg-userMessage px-2 py-1 w-14/14 focus:outline-primary cursor-text text-gray-600">

                </div>


                <div class="w-full flex flex-col gap-2 conversation-member">
                    <!-- Contact row -->
                    <div class="flex max-w-full mx-4 gap-2">
                        <div class="aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]"></div>
                        <div class="flex flex-col ">
                            <p class="font-semibold w-full text-elipsis line-clamp-1">Louise Martine </p>
                            <span class="w-full line-clamp-1 text-elipsis text-gray-500 text-xs relative top-[-3px]">Bonjour comment ça va ?</span>
                        </div>
                    </div>
                </div>




                <div class="w-full flex flex-col gap-2 conversation-member">
                    <!-- Contact row -->
                    <div class="flex max-w-full mx-4 gap-2">
                        <div class="aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]"></div>
                        <div class="flex flex-col bg-hover w-100">
                            <p class="font-semibold w-full text-elipsis line-clamp-1">Marc Antoine </p>
                            <span class="w-full line-clamp-1 text-elipsis text-gray-500 text-xs relative top-[-3px]">Je viens de t'envoyer le rapport sur ta boite mail</span>
                        </div>
                    </div>
                </div>
                <div class="w-full flex flex-col gap-2 conversation-member">
                    <!-- Contact row -->
                    <div class="flex max-w-full mx-4 gap-2">
                        <div class="aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]"></div>
                        <div class="flex flex-col">
                            <p class="font-semibold w-full text-elipsis line-clamp-1">Julien Pon </p>
                            <span class="w-full line-clamp-1 text-elipsis text-gray-500 text-xs relative top-[-3px]">Hello dispo pour un meets?</span>
                        </div>
                    </div>
                </div>

                <div class="w-full flex flex-col gap-2 conversation-member">
                    <!-- Contact row -->
                    <div class="flex max-w-full mx-4 gap-2">
                        <div class="aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]"></div>
                        <div class="flex flex-col">
                            <p class="font-semibold w-full text-elipsis line-clamp-1">Groupe A </p>
                            <span class="w-full line-clamp-1 text-elipsis text-gray-500 text-xs relative top-[-3px]">Oui bien vu</span>
                        </div>
                    </div>

                    <div id="popup" class="popup">
                        <div class="popup-content">
                            <!-- Contenu de la popup -->
                            <h2>Créer une discussion</h2>

                            <form action="" method="post" class="flex flex-col gap-2">
                                <label for="discussionName">Nom de la discussion</label>
                                <input type="text" name="discussionName" id="discussionName" required class="border border-gray-300 rounded-md px-2 py-1">

                                <!-- input that filters colleagues and displays them with click to add -->
                                <div class="flex flex-col gap-2">
                                    <div class="flex gap-2">
                                        <label for="colleagues">Ajouter des membres</label>
                                        <div id="membersSelected" class="flex gap-2"></div>
                                    </div>
                                    <input type="text" id="nameInputCreateDiscussion" placeholder="Rechercher un membre" oninput="showColleaguesFilteredCreateDiscussion()" class="border border-gray-300 rounded-md px-2 py-1">
                                    <div id="membersWrapper" class="flex flex-col gap-2 my-2 cursor-pointer select-none hover:bg-hover">

                                    </div>
                                </div>

                            </form>

                            <button id="closePopup" class="close-button">Fermer</button>
                        </div>
                    </div>

                    <style>
                        .popup {
                            display: none;
                            position: fixed;
                            top: 0;
                            left: 0;
                            width: 100%;
                            height: 100%;
                            background-color: rgba(0, 0, 0, 0.7);
                            z-index: 999;
                            align-items: center;
                            justify-content: center;
                        }

                        .popup-content {
                            background-color: white;
                            padding: 20px;
                            border-radius: 5px;
                            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
                        }

                        .close-button {
                            background-color: #1E7BFA;
                            color: white;
                            padding: 10px 20px;
                            border: none;
                            border-radius: 5px;
                            cursor: pointer;
                        }

                        .conversation-member:hover {
                            background-color: #EFF1FF;
                        }
                    </style>

                    <script>
                        // Fonction pour filtrer les messages
                        function filterMessages() {
                            // Récupérer la valeur de l'entrée de recherche
                            const searchInput = document.getElementById("searchInput");
                            const searchText = searchInput.value.toLowerCase();

                            // Sélectionner tous les messages à filtrer (les spans contenant les messages)
                            const messageSpans = document.querySelectorAll(".text-elipsis");

                            // Parcourir tous les messages et les afficher ou les masquer en fonction de la recherche
                            messageSpans.forEach(span => {
                                const messageText = span.textContent.toLowerCase();
                                if (messageText.includes(searchText)) {
                                    span.parentElement.parentElement.style.display = "block"; // Afficher le message
                                } else {
                                    span.parentElement.parentElement.style.display = "none"; // Masquer le message
                                }
                            });
                        }

                        // Écouter les événements de changement dans l'entrée de recherche
                        const searchInput = document.getElementById("searchInput");
                        searchInput.addEventListener("input", filterMessages);
                    </script>
                    <script>
                        // Fonction pour ouvrir la popup
                        function openPopup() {
                            const popup = document.getElementById("popup");
                            popup.style.display = "block";
                        }

                        // Fonction pour fermer la popup
                        function closePopup() {
                            const popup = document.getElementById("popup");
                            popup.style.display = "none";
                        }

                        // Associez la fonction openPopup au clic sur le bouton "Ajouter membre"
                        const addButton = document.querySelector("#convSection button");
                        addButton.addEventListener("click", openPopup);

                        // Associez la fonction closePopup au clic sur le bouton "Fermer"
                        const closeButton = document.querySelector("#closePopup");
                        closeButton.addEventListener("click", closePopup);


                        function showColleaguesFilteredCreateDiscussion() {

                            var nameInputCreateDiscussion = document.getElementById('nameInputCreateDiscussion');

                            if (nameInputCreateDiscussion.value.length > 0) {
                                membersWrapper.innerHTML = '';
                                for (let i = 0; i < users.length; i++) {
                                    if (users[i]['nom'].toLowerCase().includes(nameInputCreateDiscussion.value.toLowerCase()) || users[i]['prenom'].toLowerCase().includes(nameInputCreateDiscussion.value.toLowerCase())) {
                                        membersWrapper.innerHTML += `
                                        <div class='flex max-w-full mx-4 gap-2'>
                                        <div class='defaultAvatar aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]'></div>
                                            <div class='flex flex-col'>
                                                <p class='font-semibold w-full text-elipsis line-clamp-1'>${users[i]['prenom']} ${users[i]['nom']}</p>
                                                <span class='w-full line-clamp-1 text-elipsis text-gray-500 text-xs relative top-[-3px]'>${users[i]['metier']}</span>
                                            </div>
                                        </div>
                                        `;
                                    }
                                }
                            } else {
                                membersWrapper.innerHTML = '';
                                for (let i = 0; i < users.length; i++) {
                                    membersWrapper.innerHTML = ``;
                                }
                            }
                        }
                    </script>
</aside>