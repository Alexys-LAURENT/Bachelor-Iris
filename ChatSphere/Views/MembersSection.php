<?php
$colleagues = $unControleur->getAllColleagues($user['idUser']);
$metiers = array_filter(array_unique(array_column($colleagues, 'metier')));
?>
<div id="membersSection" class="lg:w-[20%] w-0 max-w-[100%] right-0 h-screen absolute lg:relative lg:block lg:bg-white bg-gray-50 overflow-hidden transition-all duration-500 border-s-2 dark:border-gray-800 dark:bg-dark dark:text-white">
    <div class="h-[50px] flex justify-between items-center p-4 border-b-2 dark:border-gray-800 transition-all duration-500">
        <p class="flex gap-2 items-center text-black dark:text-white transition-all duration-500">Membres <span class="flex items-center text-black justify-center font-semibold text-sm w-7 h-7 rounded-full bg-gray-200"><?php echo count($colleagues); ?></span></p>

        <!-- close drawer btn -->
        <div class="block lg:hidden">
            <svg class="cursor-pointer" onclick="toggleMembers()" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
                <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z" />
            </svg>
        </div>
    </div>

    <!-- content -->
    <div class="flex flex-col items-center gap-4 relative min-h-[calc(100%-50px)] max-h-[calc(100%-50px)] overflow-hidden">
        <div class="flex w-full mt-3 max-h-[50px] justify-center ">
            <div class="flex w-full ms-4 justify-between h-[30px]">
                <input onkeyup="showColleaguesFiltered()" id="nameInput" type="text" placeholder="Rechercher" class="rounded-md bg-userMessage dark:bg-darkHover px-2 py-1 w-full focus:outline-primary dark:focus:outline-black cursor-text text-gray-600 dark:text-gray-400 transition-all duration-500">
                <button onclick='handleShowFilter()' class="bg-secondary ms-2 me-4 rounded-md w-[40px] aspect-square flex justify-center items-center">
                    <svg class="relative z-0" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="white" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
                        <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z" />
                    </svg>
                </button>
            </div>
            <div id="filterPopUp" class="hidden overflow-hidden top-[50px] right-5 absolute rounded-md shadow-xl z-10 bg-white dark:bg-dark transition-all duration-500 text-black dark:text-white">
                <ul class="flex flex-col max-h-[200px] overflow-y-auto">
                    <?php
                    // order metiers alphabetically
                    sort($metiers);
                    foreach ($metiers as $i => $metier) {
                        echo "<li class='flex items-center'>
                                    <input onclick='showColleaguesFiltered()' class='checkbox-metier me-1 cursor-pointer' type='checkbox' name='" . $metier . "' id='checkbox-$i'>
                                    <label class='select-none cursor-pointer' for='checkbox-$i'>" . $metier . "</label>
                                </li>";
                    }
                    ?>
                </ul>
                <button onclick="handleShowFilter()" class="w-full text-sm bg-secondary text-white mt-1 rounded-md px-3 py-1">Fermer</button>
            </div>
        </div>

        <!-- Members -->
        <div id="membersWrapper" class="w-full flex flex-col gap-2 overflow-y-auto pb-2">
            <!-- Contact row -->
            <?php
            for ($i = 0; $i < count($colleagues); $i++) {
                echo "<div class='hover:bg-hover hover:dark:bg-darkHover rounded-md flex max-w-full mx-4 gap-2 colleagueRow' id-colleague='" . $colleagues[$i]['idUser'] . "'>
                            <div class='z-0 bg-cover bg-center aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]' style='" . ($colleagues[$i]['pp'] != 'default.webp' ? "background-image: url(https://images.chatsphere.alexyslaurent.com/" . $colleagues[$i]['pp'] . ")" : 'background-color: #' . substr(md5(utf8_encode($colleagues[$i]['idUser'])), 0, 6)) . "'>
                            <span class='flex text-2xl w-full text-white h-full justify-center items-center " . ($colleagues[$i]['pp'] != 'default.webp' ? 'hidden' : '') . "'>" . mb_substr($colleagues[$i]['prenom'], 0, 1, 'UTF-8') . mb_substr($colleagues[$i]['nom'], 0, 1, 'UTF-8') . "</span>
                            </div>
                            <div class='flex flex-col'>
                                <p class='font-semibold w-full text-elipsis line-clamp-1'>" . $colleagues[$i]['prenom'] . " " . $colleagues[$i]['nom'] . "</p>
                                <span class='w-full line-clamp-1 text-elipsis text-gray-500 text-xs relative top-[-3px]'>" . $colleagues[$i]['metier'] . "</span>
                            </div>
                        </div>";
            }
            ?>

        </div>
    </div>
</div>


<script>
    var colleagueRows = document.querySelectorAll('.colleagueRow');

    colleagueRows.forEach(colleagueRow => {
        colleagueRow.addEventListener('contextmenu', function(e) {
            e.preventDefault();
            // Si le menu existe déjà, supprimez-le
            if (document.querySelector('.contactMenu')) {
                document.querySelector('.contactMenu').remove();
            }

            var colleagueId = colleagueRow.getAttribute('id-colleague');

            // Créez le menu à la position de la souris
            var menu = document.createElement('div');
            menu.classList.add('absolute', 'z-10', 'rounded-md', 'shadow-xl', 'text-black', 'dark:text-white', 'transition-all', 'duration-500', 'flex', 'flex-col', 'overflow-hidden', 'contactMenu');

            // Décalage vers la gauche si le clic est trop proche du bord droit
            var leftPosition = e.clientX;
            if (window.innerWidth - e.clientX < 175) {
                leftPosition -= 150;
            }

            menu.style.top = e.clientY + 'px';
            menu.style.left = leftPosition + 'px';
            menu.innerHTML = `
            <button onclick="handleShowDiscussion(${colleagueId})" class="w-full text-sm bg-secondary text-white mt-1 rounded-md px-3 py-1">Envoyer un message</button>`;
            document.body.appendChild(menu);

            // Ajoutez un écouteur d'événements au document pour fermer le menu lors d'un clic en dehors
            document.addEventListener('click', function(event) {
                var isClickInsideMenu = menu.contains(event.target);
                if (!isClickInsideMenu) {
                    menu.remove();
                }
            });
        });
    });

    // disable other context menus
    document.addEventListener('contextmenu', function(e) {
        e.preventDefault();
        // console.log(e.target.closest('div'));
        // return false;
        if (e.target.parentNode.classList.contains('colleagueRow') || e.target.parentNode.parentNode.classList.contains('colleagueRow') || e.target.classList.contains('colleagueRow')) {
            return;
        } else {
            if (document.querySelector('.contactMenu')) {
                document.querySelector('.contactMenu').remove();
            }
        }
    });

    function handleShowDiscussion(idColleague) {
        // call php function to create discussion
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "createDiscussionRightClick.php", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onload = function() {
            if (xhr.status >= 200 && xhr.status < 300) {
                // get idDiscussion from response
                var idDiscussion = xhr.responseText;
                // redirect to discussion
                window.location.href = "?token=<?php echo $_GET['token']; ?>&discussion=" + idDiscussion;
            } else {
                console.log('The request failed!');
            }
        };

        xhr.send("idColleague=" + idColleague + "&idUser=" + <?php echo $user['idUser']; ?>);
    }



    membersWrapper = document.getElementById('membersWrapper');
    nameInput = document.getElementById('nameInput');
    var users = <?php echo json_encode($colleagues); ?>;


    function verifCheckbox() {
        const checkboxes = document.querySelectorAll('.checkbox-metier');

        // Initialisez une variable (aucune case cochée)
        let casesCochées = [];

        // Parcourez les cases à cocher pour voir si elles sont cochées
        for (const checkbox of checkboxes) {
            if (checkbox.checked) {
                casesCochées.push(checkbox.name);
            }
        }

        return casesCochées.length > 0 ? casesCochées : false;
    }

    function showColleaguesFiltered() {
        const casesCochées = verifCheckbox();
        if (casesCochées === false) {

            if (nameInput.value.length > 0) {
                membersWrapper.innerHTML = '';
                for (let i = 0; i < users.length; i++) {
                    if (users[i]['nom'].toLowerCase().includes(nameInput.value.toLowerCase()) || users[i]['prenom'].toLowerCase().includes(nameInput.value.toLowerCase())) {
                        membersWrapper.innerHTML += `<div class='flex max-w-full mx-4 gap-2'>
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
                    </div>`;
                    }
                }
            } else {
                membersWrapper.innerHTML = '';
                for (let i = 0; i < users.length; i++) {
                    membersWrapper.innerHTML += `<div class='flex max-w-full mx-4 gap-2'>
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
                            </div>`;
                }
            }
        } else {
            if (nameInput.value.length > 0) {
                membersWrapper.innerHTML = '';
                for (let i = 0; i < users.length; i++) {
                    if ((users[i]['nom'].toLowerCase().includes(nameInput.value.toLowerCase()) || users[i]['prenom'].toLowerCase().includes(nameInput.value.toLowerCase())) && casesCochées.includes(users[i]['metier'])) {
                        membersWrapper.innerHTML += `<div class='flex max-w-full mx-4 gap-2'>
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
                                </div>`;
                    }
                }
            } else {
                membersWrapper.innerHTML = '';
                for (let i = 0; i < users.length; i++) {
                    if (casesCochées.includes(users[i]['metier'])) {
                        membersWrapper.innerHTML += `<div class='flex max-w-full mx-4 gap-2'>
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
                                </div>`;
                    }
                }
            }
        }
    }
</script>