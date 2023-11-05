<?php
$colleagues = $unControleur->getAllColleagues($user['idUser']);
$metiers = array_filter(array_unique(array_column($colleagues, 'metier')));
?>
<div id="membersSection" class="lg:w-[20%] w-0 max-w-[100%] right-0 h-screen absolute lg:relative lg:block lg:bg-white bg-gray-50 overflow-hidden transition-all duration-500 border-s-2 dark:bg-dark dark:text-white">
    <div class="h-[50px] flex justify-between items-center p-4 border-b-2 transition-all duration-500">
        <p class="flex gap-2 items-center transition-all duration-500 text-black dark:text-white">Membres <span class="flex items-center text-black justify-center font-semibold text-sm w-7 h-7 rounded-full bg-gray-200"><?php echo count($colleagues); ?></span></p>

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
            <div class="flex w-full ps-4 justify-between">
                <input onkeyup="showColleaguesFiltered()" id="nameInput" type="text" placeholder="Rechercher" class="rounded-md bg-gray-100 px-2 py-1 w-10/12 focus:outline-border cursor-text text-gray-600">
                <button onclick='handleShowFilter()' class="bg-secondary ms-2 me-4 rounded-md w-2/12 max-w-[50px] aspect-square flex justify-center items-center">
                    <svg class="relative z-0" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="white" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
                        <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z" />
                    </svg>
                </button>
            </div>
            <div id="filterPopUp" class="max-h-0 overflow-hidden top-[70px] right-6 absolute rounded-md shadow-xl z-10 bg-white dark:bg-dark transition-all duration-500 text-black dark:text-white">
                <ul class="flex flex-col">
                    <?php
                    foreach ($metiers as $i => $metier) {
                        echo "<li class='flex items-center'>
                                    <input onclick='showColleaguesFiltered()' class='checkbox-metier me-1 cursor-pointer' type='checkbox' name='" . $metier . "' id='checkbox-$i'>
                                    <label class='select-none cursor-pointer' for='checkbox-$i'>" . $metier . "</label>
                                </li>";
                    }
                    ?>
                    <button onclick="handleShowFilter()" class="text-sm bg-secondary text-white mt-1 rounded-md px-3 py-1">Fermer</button>
                </ul>
            </div>
        </div>

        <!-- Members -->
        <div id="membersWrapper" class="w-full flex flex-col gap-2 overflow-y-auto pb-2">
            <!-- Contact row -->
            <?php
            for ($i = 0; $i < count($colleagues); $i++) {
                echo "<div class='flex max-w-full mx-4 gap-2'>
                            <div class='bg-cover bg-center aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]' style='background-image: url(http://images.foda4953.odns.fr/" . $colleagues[$i]['pp'] . ")'
                            ></div>
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
                                <div class='bg-cover bg-center aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]' style='background-image: url(http://images.foda4953.odns.fr/${users[i]['pp']})'></div>
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
                                <div class='bg-cover bg-center aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]' style='background-image: url(http://images.foda4953.odns.fr/${users[i]['pp']})'></div>
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
                                <div class='bg-cover bg-center aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]' style='background-image: url(http://images.foda4953.odns.fr/${users[i]['pp']})'></div>
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
                                <div class='bg-cover bg-center aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]' style='background-image: url(http://images.foda4953.odns.fr//${users[i]['pp']})'></div>
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