<?php

$discussions = $unControleur->getDiscussionsDetails($user['idUser']);
$colleagues = $unControleur->getAllColleagues($user['idUser']);

if (isset($_POST['createDiscussion'])) {
    $discussionName = $_POST['NewDiscussionName'] == "" ? null : $_POST['NewDiscussionName'];
    $createDiscussion = $unControleur->createDiscussion($discussionName, array_merge($_POST['members'], array($user['idUser'])));
    // create or replace get parameter discussion
    header('Location: ?token=' . $_GET['token'] . '&discussion=' . $createDiscussion);
}
?>
<div id="convSection" class="lg:w-[23%] w-0 left-0 max-w-[100%]  h-screen absolute lg:relative lg:block lg:bg-white bg-gray-50 overflow-hidden transition-all duration-500 border-e-2 z-10 dark:bg-dark dark:text-white">
    <div class="h-[50px] flex justify-between items-center p-4 border-b-2">

        <div class="flex items-center">
            <p class="flex gap-2 items-center">Discussions <span class="flex items-center text-black justify-center font-semibold text-sm w-7 h-7 rounded-full bg-gray-200"><?php echo count($discussions); ?></span></p>
        </div>
        <div class="flex gap-2 items-center">

            <button class="bg-secondary w-7 h-7 rounded-full flex justify-center items-center ">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M12 4v16m8-8H4" />
                </svg>
            </button>
            <!-- close drawer btn -->
            <div class="block lg:hidden  ">
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
                <input id="searchInput" type="text" placeholder="Rechercher" class="rounded-md bg-userMessage px-2 py-1 w-full focus:outline-primary cursor-text text-gray-600">

            </div>

            <div class="w-full flex flex-col gap-2 overflow-y-auto h-[calc(100vh-180px)]
            ">
                <?php
                foreach ($discussions as $discussion) {
                    isset($_GET['discussion']) ? $getDiscussion = $_GET['discussion'] : $getDiscussion = null;
                    $class = $getDiscussion == $discussion['idDiscussion'] ? 'bg-hover dark:text-black' : '';
                    echo '
                <a href="?token=' . $_GET['token'] . '&discussion=' . $discussion['idDiscussion'] . '" class="px-2 p-0 w-full dark:hover:text-black">
                    <div class="w-full flex flex-col gap-2 hover:bg-hover hover:cursor-pointer rounded-md py-2 ' . $class . ' ">
                        <!-- Contact row -->
                        <div class="flex max-w-full mx-3 gap-2">
                            <div class="bg-cover bg-center aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]" style="background-image: url(../../usersImages/' . $discussion['pp'] . ');"
                            ></div>
                            <div class="flex flex-col ">
                                <p class="font-semibold w-full text-elipsis line-clamp-1">' . $discussion['nom'] . '</p>
                                <span class="conversationRow w-full max-w-full line-clamp-1 text-elipsis text-gray-500 text-xs relative top-[-3px] text-elipsis line-clamp-1">' . $discussion['dernier_message'] . '</span>
                            </div>
                        </div>
                    </div>
                </a>';
                }
                ?>
            </div>

            <div class="flex gap-2 w-full h-[68px] border-t-2 border-gray-200 items-center px-3 justify-between">
                <div class="flex gap-2">
                    <div class="bg-cover bg-center aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]" style="background-image: url(../../usersImages/<?php echo $user['pp']; ?>);"></div>
                    <div class="flex flex-col w-full">
                        <p class="font-semibold w-full text-elipsis line-clamp-1"><?php echo $user['nom'] . ' ' . $user['prenom']; ?></p>

                        <div class="flex relative">
                            <!-- popup statut -->
                            <div id="statutPopup" class="hidden absolute bottom-[25px] w-[150px] border border-gray-200 rounded-md shadow-md z-10 bg-white dark:bg-dark text-gray-500 dark:text-gray-300">
                                <div class="flex items-center gap-1 hover:cursor-pointer hover:bg-gray-200 rounded-md px-2 py-1 dark:hover:text-black">
                                    <div onclick="ChangeStatut('En ligne')" class="w-2 h-2 rounded-full bg-green-500">
                                    </div>
                                    <p class="text-xs">En ligne</p>
                                </div>
                                <div class="flex items-center gap-1 hover:cursor-pointer hover:bg-gray-200 rounded-md px-2 py-1 dark:hover:text-black">
                                    <div onclick="ChangeStatut('Absent')" class="w-2 h-2 rounded-full bg-yellow-500">
                                    </div>
                                    <p class="text-xs">Absent</p>
                                </div>
                                <div class="flex items-center gap-1 hover:cursor-pointer hover:bg-gray-200 rounded-md px-2 py-1 dark:hover:text-black">
                                    <div onclick="ChangeStatut('Occupé')" class="w-2 h-2 rounded-full bg-red-500">
                                    </div>
                                    <p class="text-xs">Occupé</p>
                                </div>
                                <div class="flex items-center gap-1 hover:cursor-pointer hover:bg-gray-200 rounded-md px-2 py-1 dark:hover:text-black">
                                    <div onclick="ChangeStatut('Hors ligne')" class="w-2 h-2 rounded-full bg-gray-500">
                                    </div>
                                    <p class="text-xs">Hors ligne</p>
                                </div>
                            </div>

                            <div onclick="toggleStatut()" class="flex items-center gap-1 hover:cursor-pointer hover:bg-gray-200 rounded-md px-2 py-1 text-gray-500 dark:text-gray-300 dark:hover:text-black">
                                <div class="w-2 h-2 rounded-full bg-green-500"></div>
                                <p class="text-xs">En ligne</p>
                                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="mt-[0.15rem] bi bi-chevron-up" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M7.646 4.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1-.708.708L8 5.707l-5.646 5.647a.5.5 0 0 1-.708-.708l6-6z" />
                                </svg>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="">
                    <div onclick="document.getElementsByTagName('html').item(0).classList.toggle('dark')" class="w-7 h-7 rounded-full flex justify-center items-center bg-gray-200">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-gray-500" fill="currentColor" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M8 0a8 8 0 1 0 0 16A8 8 0 0 0 8 0ZM4 8a4 4 0 0 1 4-4h4a4 4 0 1 1-4 4H4Z" />
                        </svg>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>


<script>
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
</script>

</aside>