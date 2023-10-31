<?php
$discussions = $unControleur->getDiscussionsDetails($user['idUser']);
$colleagues = $unControleur->getAllColleagues($user['idUser']);

if (isset($_POST['createDiscussion'])) {
    // post members + $user['idUser'] in single array
    $unControleur->createDiscussion($_POST['NewDiscussionName'], array_merge($_POST['members'], array($user['idUser'])));
    header("Refresh:0");
}
?>
<aside id="convSection" class="lg:w-[23%] w-0 left-0 max-w-[100%]  h-screen absolute lg:relative lg:block lg:bg-white bg-gray-50 overflow-hidden transition-all duration-500 border-e-2">
    <div class="h-[50px] flex justify-between items-center p-4 border-b-2">

        <div class="flex items-center">
            <p class="flex gap-2 items-center">Messages <span class="flex items-center justify-center font-semibold text-sm w-7 h-7 rounded-full bg-gray-200">4</span></p>
        </div>
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

    <div class="flex justify-center ">
        <!-- content -->
        <div>

            <div class="flex flex-col items-center gap-1 relative px-4">
                <div class="flex w-14/14 mt-3 justify-between">
                    <input id="searchInput" type="text" placeholder="Rechercher un message" class="rounded-md bg-userMessage px-2 py-1 w-full focus:outline-primary cursor-text text-gray-600">

                </div>


                <div class="w-full flex flex-col gap-2 hover:bg-hover hover:cursor-pointer rounded-md py-2">
                    <!-- Contact row -->
                    <div class="flex max-w-full mx-4 gap-2">
                        <div class="aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]"></div>
                        <div class="flex flex-col ">
                            <p class="font-semibold w-full text-elipsis line-clamp-1">Louise Martine </p>
                            <span class="conversationRow w-full line-clamp-1 text-elipsis text-gray-500 text-xs relative top-[-3px]">Bonjour comment ça va ?</span>
                        </div>
                    </div>
                </div>

                <div class="w-full flex flex-col gap-2 hover:bg-hover  hover:cursor-pointer bg-hover rounded-md py-2">
                    <!-- Contact row -->
                    <div class="flex max-w-full mx-4 gap-2">
                        <div class="aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]"></div>
                        <div class="flex flex-col" >
                            <p class="font-semibold w-full text-elipsis line-clamp-1">Marc Antoine </p>
                            <span class="conversationRow w-full line-clamp-1 text-elipsis text-gray-500 text-xs relative top-[-3px]">Je viens de t'envoyer le rapport sur ta boite mail</span>
                        </div>
                    </div>
                </div>
                <div class="w-full flex flex-col gap-2 hover:bg-hover hover:cursor-pointer rounded-md py-2">
                    <!-- Contact row -->
                    <div class="flex max-w-full mx-4 gap-2">
                        <div class="aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]"></div>
                        <div class="flex flex-col">
                            <p class="font-semibold w-full text-elipsis line-clamp-1">Julien Pon </p>
                            <span class="conversationRow w-full line-clamp-1 text-elipsis text-gray-500 text-xs relative top-[-3px]">Hello dispo pour un meets?</span>
                        </div>
                    </div>
                </div>

                <div class="w-full flex flex-col gap-2 hover:bg-hover hover:cursor-pointer rounded-md py-2">
                    <!-- Contact row -->
                    <div class="flex max-w-full mx-4 gap-2">
                        <div class="aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]"></div>
                        <div class="flex flex-col">
                            <p class="font-semibold w-full text-elipsis line-clamp-1">Groupe A </p>
                            <span class="conversationRow w-full line-clamp-1 text-elipsis text-gray-500 text-xs relative top-[-3px]">Oui bien vu</span>
                        </div>
                    </div>
                </div>

                <?php require_once('popUpCreateDiscussion.php'); ?>


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
                </script>

</aside>