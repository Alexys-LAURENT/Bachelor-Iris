<div id="popup" class="popup">
    <div id="popup-content" class="hidden w-full mx-4 md:mx-0 md:w-6/12 p-[20px] shadow-md bg-white rounded-sm dark:bg-dark z-50">
        <!-- Contenu de la popup -->
        <h2 class="text-center font-bold text-2xl mb-4">Créer une discussion</h2>

        <form action="" method="post" class="flex flex-col gap-4" autocomplete="off">
            <div id="groupNameWrapper" class="w-full flex flex-col gap-2 hidden">
                <label for="NewDiscussionName">Nom de la discussion</label>
                <input type="text" name="NewDiscussionName" id="NewDiscussionName" class="border border-gray-300 rounded-md px-2 py-1 focus:outline-none focus:drop-shadow focus:drop-shadow-secondary text-black">
            </div>

            <!-- input that filters colleagues and displays them with click to add -->
            <div class="flex flex-col gap-2">
                <div class="flex flex-col items-start">
                    <label for="colleagues">Ajouter un ou plusieurs membres</label>
                    <div id="membersSelected" class="flex gap-2 w-full flex-wrap max-h-[100px] overflow-y-auto">
                        <!-- checkboxes for each colleague -->
                        <?php
                        foreach ($colleagues as $colleague) {
                            echo '                  
                                <input onclick="checkIsGroup()" type="checkbox" name="members[]" value="' . $colleague['idUser'] . '" id="colleague-' . $colleague['idUser'] . '" class="checkboxesNewDiscussion hidden">
                                <label class=" flex items-center gap-1 cursor-pointer border border-gray-300 rounded-md px-2 py-1 hover:bg-red-500 hover:text-white transition-all duration-300 text-xs" for="colleague-' . $colleague['idUser'] . '">
                                <div class="z-0 bg-cover bg-center aspect-square rounded-full bg-gray-500 w-[20px] h-[20px]" style="' . ($colleague['pp'] != 'default.webp' ? "background-image: url(http://images.foda4953.odns.fr/" . $colleague['pp'] . ")" : "background-color: #" . substr(md5(utf8_encode($colleague['idUser'])), 0, 6)) . '">
                                <span class="flex text-2xs w-full text-white h-full justify-center items-center ' . ($colleague['pp'] != 'default.webp' ? 'hidden' : '') . '">' . mb_substr($colleague['prenom'], 0, 1, 'UTF-8') . mb_substr($colleague['nom'], 0, 1, 'UTF-8') . '</span>
                                </div>
                                    ' . $colleague['prenom'] . ' ' . $colleague['nom'] . '
                                    <svg  xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 opacity-60" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M6 18L18 6M6 6l12 12" />
                                        </svg>
                                </label>
                                ';
                        }
                        ?>
                    </div>
                </div>
                <input type="text" id="nameInputCreateDiscussion" placeholder="Rechercher un membre" oninput="showColleaguesFilteredCreateDiscussion()" class="border border-gray-300 rounded-md px-2 py-1 focus:outline-none focus:drop-shadow focus:drop-shadow-secondary text-black">
                <div id="membersWrapperNewDiscussion" class="flex flex-col select-none max-h-[300px] overflow-y-auto">

                </div>
            </div>

            <div class="flex gap-1">
                <button type="submit" name="createDiscussion" class="bg-secondary text-white rounded-md text-sm py-1 px-2 hover:scale-105 transition-all">Créer</button>
                <input type="button" id="closePopup" class="text-white rounded-md text-sm py-1 px-2 bg-red-500 hover:scale-105 transition-all" value="Annuler">
            </div>
        </form>
    </div>
</div>

<script>
    function checkIsGroup() {
        var checkboxes = document.querySelectorAll('.checkboxesNewDiscussion');
        var groupNameWrapper = document.getElementById('groupNameWrapper');
        var NewDiscussionName = document.getElementById('NewDiscussionName');

        var checkedNumber = 0;
        checkboxes.forEach(checkbox => {
            if (checkbox.checked) {
                checkedNumber++;
            }
        });

        if (checkedNumber > 1) {
            groupNameWrapper.classList.remove('hidden');
            NewDiscussionName.required = true;
        } else {
            groupNameWrapper.classList.add('hidden');
            NewDiscussionName.required = false;
            NewDiscussionName.value = '';
        }
    }

    function showColleaguesFilteredCreateDiscussion() {

        var nameInputCreateDiscussion = document.getElementById('nameInputCreateDiscussion');

        if (nameInputCreateDiscussion.value.length > 0) {
            membersWrapperNewDiscussion.innerHTML = '';

            for (let i = 0; i < users.length; i++) {
                if (users[i]['nom'].toLowerCase().includes(nameInputCreateDiscussion.value.toLowerCase()) || users[i]['prenom'].toLowerCase().includes(nameInputCreateDiscussion.value.toLowerCase())) {
                    membersWrapperNewDiscussion.innerHTML += `
                        <div class='flex max-w-full gap-2 hover:bg-hover px-3 py-2 rounded-md cursor-pointer dark:hover:text-black' onclick='checkCheckbox(${users[i]['idUser']})'>
                        <div class='bg-cover bg-center aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]' 
                            style='${users[i]['pp'] !== 'default.webp' ? 
                                `background-image: url(https://images.chatsphere.alexyslaurent.com/${users[i]['pp']})` : 
                                `background-color: #${CryptoJS.MD5(CryptoJS.enc.Utf8.parse(users[i]['idUser'])).toString().substring(0, 6)}`}'>
                            ${users[i]['pp'] === 'default.webp' ? `<span class='flex text-2xl w-full text-white h-full justify-center items-center'>${users[i]['prenom'].charAt(0)}${users[i]['nom'].charAt(0)}</span>` : ''}
                        </div>
                        <div class='flex flex-col'>
                        <p class='font-semibold w-full text-elipsis line-clamp-1'>${users[i]['prenom']} ${users[i]['nom']}</p>
                        <span class='w-full line-clamp-1 text-elipsis text-gray-500 text-xs relative top-[-3px]'>${users[i]['metier']}</span>
                        </div>
                        </div>
                        `;
                }
            }
        } else {
            membersWrapperNewDiscussion.innerHTML = '';
            for (let i = 0; i < users.length; i++) {
                membersWrapperNewDiscussion.innerHTML = ``;
            }
        }
    }

    function checkCheckbox(id) {
        var checkbox = document.getElementById('colleague-' + id);
        checkbox.checked = true;
        checkIsGroup();
    }


    // Fonction pour ouvrir la popup
    function openPopup() {
        const popup = document.getElementById("popup");
        popup.style.display = "flex";
        document.getElementById('popup-content').classList.remove('hidden');
    }

    // Fonction pour fermer la popup
    function closePopup() {
        const popup = document.getElementById("popup");
        var checkboxes = document.querySelectorAll('.checkboxesNewDiscussion');
        checkboxes.forEach(checkbox => {
            checkbox.checked = false;
        });
        document.getElementById('nameInputCreateDiscussion').value = '';
        document.getElementById('membersWrapperNewDiscussion').innerHTML = '';
        document.getElementById('NewDiscussionName').value = '';
        document.getElementById('groupNameWrapper').classList.add('hidden');
        popup.style.display = "none";
        document.getElementById('popup-content').classList.add('hidden');
    }

    // Associez la fonction openPopup au clic sur le bouton "Ajouter membre"
    const addButton = document.querySelector("#convSection button");
    addButton.addEventListener("click", openPopup);

    // Associez la fonction closePopup au clic sur le bouton "Fermer"
    const closeButton = document.querySelector("#closePopup");
    closeButton.addEventListener("click", closePopup);

    // Fonction pour vérifier si le clic a eu lieu en dehors de popup-content
    function handleClickOutside(event) {
        const popupContent = document.getElementById('popup-content');
        // Vérifier si le clic a eu lieu en dehors de popup-content
        if (!popupContent.contains(event.target)) {
            closePopup();
        }
    }

    // Ajouter l'écouteur d'événements au conteneur de la popup
    const popup = document.getElementById('popup');
    popup.addEventListener('click', handleClickOutside);
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

    .conversation-member:hover {
        background-color: #EFF1FF;
    }

    input[type="checkbox"].checkboxesNewDiscussion:not(:checked)+label {
        display: none;
    }
</style>