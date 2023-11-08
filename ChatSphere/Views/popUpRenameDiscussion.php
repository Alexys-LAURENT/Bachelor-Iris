<div id="popupRenameDiscussion" class="popup">
    <div id="popup-contentRenameDiscussion" class="hidden w-full mx-4 md:mx-0 md:w-6/12 p-[20px] shadow-md bg-white rounded-sm dark:bg-dark z-50 text-black dark:text-white flex flex-col gap-4">
        <!-- Contenu de la popup -->
        <div>
            <h2 class="text-center font-bold text-2xl mb-4">Renommer la discussion</h2>
            <form action="" method="post" class="flex flex-col gap-4" autocomplete="off">

                <input type="text" name="inputRenameDiscussion" id="inputRenameDiscussion" placeholder="Nouveau nom du groupe" class="border border-gray-300 rounded-md px-2 py-1 focus:outline-none focus:drop-shadow focus:drop-shadow-secondary text-black">

                <div class="flex gap-1">
                    <button type="submit" name="renameDiscussion" class="bg-secondary text-white rounded-md text-sm py-1 px-2 hover:scale-105 transition-all">Confirmer</button>
                    <input type="button" id="closePopupRenameDiscussion" class="text-white rounded-md text-sm py-1 px-2 bg-red-500 hover:scale-105 transition-all cursor-pointer" value="Annuler">
                </div>
            </form>
        </div>

        <div>
            <h2 class="text-center font-bold text-2xl mb-4">Supprimer la discussion</h2>
            <form action="" method="post" class="flex flex-col gap-4" autocomplete="off">
                <!-- message d'avertissement -->
                <p class="text-center text-red-500">Attention, cette action est irréversible !</p>

                <!-- generate a random number to confirm the deletion -->
                <div class="flex flex-col gap-2">
                    <input type="number" id="randomNumberDeleteDiscussion" name="randomNumberDeleteDiscussion" value="" class="border border-gray-300 rounded-md px-2 py-1 focus:outline-none focus:drop-shadow focus:drop-shadow-secondary text-black dark:text-white select-none bg-gray-500 hidden" readonly>
                    <div class="text-black dark:text-white ps-2" id="displayRandomNumber"></div>
                    <input type="number" name="inputDeleteDiscussion" id="inputDeleteDiscussion" placeholder="Veuillez entrez le numéro ci-dessus pour confirmer" class="border border-gray-300 rounded-md px-2 py-1 focus:outline-none focus:drop-shadow focus:drop-shadow-secondary text-black">
                </div>

                <div class="flex gap-1">
                    <button type="submit" id="deleteDiscussionButton" name="deleteDiscussion" class="bg-gray-500 text-white rounded-md text-sm py-1 px-2 transition-all" disabled>Supprimer la discussion</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Fonction pour ouvrir la popup
    function openPopupRenameDiscussion() {
        const popup = document.getElementById("popupRenameDiscussion");
        popup.style.display = "flex";
        document.getElementById('popup-contentRenameDiscussion').classList.remove('hidden');
        document.getElementById('randomNumberDeleteDiscussion').value = Math.floor(100000 + Math.random() * 900000);
        document.getElementById('displayRandomNumber').innerHTML = document.getElementById('randomNumberDeleteDiscussion').value;
    }

    // Fonction pour fermer la popup
    function closePopupRenameDiscussion() {
        const popupRenameDiscussion = document.getElementById("popupRenameDiscussion");
        popupRenameDiscussion.style.display = "none";
        document.getElementById('popup-contentRenameDiscussion').classList.add('hidden');

        // Vider les inputs
        document.getElementById('inputDeleteDiscussion').value = "";
        document.getElementById('inputRenameDiscussion').value = "";

    }

    // Associez la fonction openPopupRenameDiscussion au clic sur le bouton
    const addButtonRenameDiscussion = document.querySelector("#buttonRenameDiscussion");
    addButtonRenameDiscussion.addEventListener("click", openPopupRenameDiscussion);

    // Associez la fonction closePopup au clic sur le bouton "Fermer"
    const closeButtonRenameDiscussion = document.querySelector("#closePopupRenameDiscussion");
    closeButtonRenameDiscussion.addEventListener("click", closePopupRenameDiscussion);

    // Associez la fonction checkValidationNumber a l'input
    const inputDeleteDiscussion = document.querySelector("#inputDeleteDiscussion");
    inputDeleteDiscussion.addEventListener("keyup", checkValidationNumber);

    // Fonction pour vérifier si le clic a eu lieu en dehors de popup-content
    function handleClickOutsideRenameDiscussion(event) {
        const popupContent = document.getElementById('popup-contentRenameDiscussion');
        // Vérifier si le clic a eu lieu en dehors de popup-content
        if (!popupContent.contains(event.target)) {
            closePopupRenameDiscussion();
            checkValidationNumber();
        }
    }

    // Ajouter l'écouteur d'événements au conteneur de la popup
    const popupRenameDiscussion = document.getElementById('popupRenameDiscussion');
    popupRenameDiscussion.addEventListener('click', handleClickOutsideRenameDiscussion);

    function checkValidationNumber() {
        var inputDeleteDiscussion = document.getElementById('inputDeleteDiscussion');
        var randomNumber = document.getElementById('randomNumberDeleteDiscussion').value;
        var deleteButton = document.getElementById('deleteDiscussionButton');
        if (inputDeleteDiscussion.value == randomNumber) {
            deleteButton.disabled = false;
            deleteButton.classList.add('bg-red-500');
            deleteButton.classList.add('hover:scale-105');
            deleteButton.classList.add('cursor-pointer');
        } else {
            deleteButton.disabled = true;
            deleteButton.classList.remove('bg-red-500');
            deleteButton.classList.remove('hover:scale-105');
            deleteButton.classList.remove('cursor-pointer');
        }
    }
</script>


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
</style>