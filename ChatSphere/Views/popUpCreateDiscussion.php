<div id="popup" class="popup">
    <div id="popup-content" class="hidden w-full mx-4 md:mx-0 md:w-6/12 p-[20px] shadow-md bg-white rounded-sm">
        <!-- Contenu de la popup -->
        <h2 class="text-center font-bold text-2xl">Créer une discussion</h2>

        <form action="" method="post" class="flex flex-col gap-2">
            <label for="NewDiscussionName">Nom de la discussion</label>
            <input type="text" name="NewDiscussionName" id="NewDiscussionName" required class="border border-gray-300 rounded-md px-2 py-1 focus:outline-none focus:drop-shadow focus:drop-shadow-secondary">

            <!-- input that filters colleagues and displays them with click to add -->
            <div class="flex flex-col gap-2">
                <div class="flex flex-col items-start gap-2">
                    <label for="colleagues">Ajouter des membres</label>
                    <div id="membersSelected" class="flex gap-2 w-full flex-wrap max-h-[100px] overflow-y-auto">
                        <!-- checkboxes for each colleague -->
                        <?php
                        foreach ($colleagues as $colleague) {
                            echo '                  
                                                    <input type="checkbox" name="members[]" value="' . $colleague['idUser'] . '" id="colleague-' . $colleague['idUser'] . '" class="checkboxesNewDiscussion hidden">
                                                    <label class=" flex items-center gap-1 cursor-pointer border border-gray-300 rounded-md px-2 py-1 hover:bg-red-500 hover:text-white transition-all duration-300 text-xs" for="colleague-' . $colleague['idUser'] . '">
                                                    
                                                        <div class="bg-cover bg-center aspect-square rounded-full bg-gray-500 w-[20px] h-[20px]" style="background-image: url(../../usersImages/' . $colleague['pp'] . ')"></div>
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
                <input type="text" id="nameInputCreateDiscussion" placeholder="Rechercher un membre" oninput="showColleaguesFilteredCreateDiscussion()" class="border border-gray-300 rounded-md px-2 py-1 focus:outline-none focus:drop-shadow focus:drop-shadow-secondary">
                <div id="membersWrapperNewDiscussion" class="flex flex-col select-none max-h-[300px] overflow-y-auto">

                </div>
            </div>

            <div class="flex gap-1">
                <button type="submit" name="createDiscussion" class="bg-secondary text-white rounded-md text-sm py-1 px-2 hover:scale-105 transition-all">Créer</button>
                <button id="closePopup" class="text-white rounded-md text-sm py-1 px-2 bg-red-500 hover:scale-105 transition-all">Annuler</button>
            </div>
        </form>
    </div>
</div>

<script>
    function showColleaguesFilteredCreateDiscussion() {

        var nameInputCreateDiscussion = document.getElementById('nameInputCreateDiscussion');

        if (nameInputCreateDiscussion.value.length > 0) {
            membersWrapperNewDiscussion.innerHTML = '';

            for (let i = 0; i < users.length; i++) {
                if (users[i]['nom'].toLowerCase().includes(nameInputCreateDiscussion.value.toLowerCase()) || users[i]['prenom'].toLowerCase().includes(nameInputCreateDiscussion.value.toLowerCase())) {
                    membersWrapperNewDiscussion.innerHTML += `
                        <div class='flex max-w-full gap-2 hover:bg-hover px-3 py-2 rounded-md cursor-pointer' onclick='checkCheckbox(${users[i]['idUser']})'>
                        <div class='bg-cover bg-center aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]' style='background-image: url(../../usersImages/${users[i]['pp']})'></div>
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
        popup.style.display = "none";
        document.getElementById('popup-content').classList.add('hidden');
    }

    // Associez la fonction openPopup au clic sur le bouton "Ajouter membre"
    const addButton = document.querySelector("#convSection button");
    addButton.addEventListener("click", openPopup);

    // Associez la fonction closePopup au clic sur le bouton "Fermer"
    const closeButton = document.querySelector("#closePopup");
    closeButton.addEventListener("click", closePopup);
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