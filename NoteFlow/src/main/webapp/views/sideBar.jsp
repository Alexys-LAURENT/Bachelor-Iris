<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- get all user Tags --%>

<%
    ArrayList<Tag> AllTagsUser = Controller.getUserTags(user.getIdUser());
%>




<div
    class="flex min-h-[150px] md:min-h-0 flex-col bg-white w-full md:w-2/12 md:min-w-[250px] md:max-w-[250px] md:h-screen overflow-x-hidden pt-2 gap-4 transition-colors duration-500 md:border-e-2 dark:border-gray-800 z-10 dark:bg-dark dark:text-white <%= request.getParameter("note") != null ? "hidden" : "" %>">

    <!-- Title -->
    <div class="flex justify-between px-4">
        <div class="md:w-full flex justify-between gap-2 items-center">
            <h1 class="text-xl">Mes notes</h1>
            <div class="flex gap-2 items-center">
                <button class="bg-[#0f68a9] w-7 h-7 rounded-full flex justify-center items-center" onclick="showToastCreateNote()">
                    <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M12 4v16m8-8H4"></path>
                    </svg>
                </button>
            </div>
        </div>
        <div class="flex gap-2 items-center">
        <div class="avatar md:hidden w-8 h-8 rounded-full bg-cover bg-center" style="background-image: url(https://images.chatsphere.alexyslaurent.com/<%= user.getPp() %>);"></div>
            <div onclick="toggleThemeMode()" class="hover:cursor-pointer md:hidden ">
                <svg id="moonSvgSm" class="hidden min-w-[25px]" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="white" class="bi bi-moon-fill" viewBox="0 0 16 16">
                    <path d="M6 .278a.768.768 0 0 1 .08.858 7.208 7.208 0 0 0-.878 3.46c0 4.021 3.278 7.277 7.318 7.277.527 0 1.04-.055 1.533-.16a.787.787 0 0 1 .81.316.733.733 0 0 1-.031.893A8.349 8.349 0 0 1 8.344 16C3.734 16 0 12.286 0 7.71 0 4.266 2.114 1.312 5.124.06A.752.752 0 0 1 6 .278z" />
                </svg>

                <svg id="sunSvgSm" class="hidden min-w-[25px]" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="black" class="bi bi-sun-fill" viewBox="0 0 16 16">
                    <path d="M8 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z" />
                </svg>
            </div>
            </div>
    </div>

    <!-- Search input -->
    <div class="px-4">
        <input type="text" class="w-full bg-white border rounded-md h-9 focus:outline-none px-2 text-black dark:bg-darkNote dark:text-white dark:border-gray-800 transition-all duration-500"
            placeholder="Rechercher une note" name="searchInput" id="searchInput">
    </div>

    <div class=" md:h-full overflow-hidden">
        <div id="tagsWrapper" class="flex md:flex-col h-full relative scroll-shadow-s after:transition-all after:duration-500">
            <div id="tagsContainer"
                class="tagsContainer relative flex hide-scrollbar md:flex-col md:items-center min-h-[10px] h-full overflow-auto gap-2 py-2 w-full md:ps-4 md:mx-0 mx-4">
                <%-- Favoris --%>
                <div onclick="toggleOnlyFavParams()"
                    class="mb-0 md:mb-3 text-xs px-2 py-1 bg-[#FFF5E5] flex w-fit rounded-md md:w-full md:justify-center md:max-w-full md:text-base md:py-1 md:font-semibold cursor-pointer select-none <%= request.getParameter("onlyFav") != null && "true".equals(request.getParameter("onlyFav")) ? "outline outline-[2.5px] outline-[#F18600]" : "" %>">
                    <p class="text-[#F18600]">Favoris</p>
                </div>

                <%-- Tags --%>
                <% for (Tag tag : AllTagsUser) { %>
                <div onclick="toggleTagParams(<%= tag.getIdTag() %>)"
                    class="text-xs px-2 py-1 dark:bg-[<%= tag.getHex() %>]/50 bg-[<%= tag.getHex() %>]/50 flex w-fit rounded-md md:w-full md:justify-center md:max-w-full md:text-base md:py-1 md:font-semibold cursor-pointer select-none outline-[<%= tag.getHex() %>] <%= request.getParameter("tag") != null && request.getParameter("tag").equals(String.valueOf(tag.getIdTag())) ? "outline outline-[2.5px]" : "" %>">
                    <p class="text-[<%= tag.getHex() %>]"><%= tag.getLibelle() %></p>
                </div>
                <% } %>

                <%-- Add tag --%>
                <div onclick="showToastCreateTag()"
                    class="text-xs px-2 py-1 dark:bg-darkNote bg-white flex w-fit rounded-md md:w-full justify-center md:py-1 md:font-semibold cursor-pointer select-none border border-green-500 md:min-h-[32px] transition-all duration-500">
                    <p class="flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="md:h-6 md:w-6 bi bi-plus fill-green-500" viewBox="0 0 16 16">
                            <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
                        </svg>
                    </p>
                </div>
            </div>

            <!-- footer -->
            <footer
                class="hidden md:flex w-full h-[68px] border-t-2 items-center flex gap-2 px-3 justify-between transition-all duration-500 dark:border-gray-800">
                <div class="flex gap-2 items-center">
                    <div class="bg-cover bg-center aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]" style="background-image: url(https://images.chatsphere.alexyslaurent.com/<%= user.getPp() %>);"></div>
                    <p class="font-semibold w-full text-elipsis line-clamp-1 text-black transition-all duration-500 dark:text-white">
                        <%= user.getPrenom() + " " + user.getNom() %>
                    </p>
                </div>
                <div>
                    <div onclick="toggleThemeMode()" class="hover:cursor-pointer">
                        <svg id="moonSvg" class="hidden" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="white" class="bi bi-moon-fill" viewBox="0 0 16 16">
                            <path d="M6 .278a.768.768 0 0 1 .08.858 7.208 7.208 0 0 0-.878 3.46c0 4.021 3.278 7.277 7.318 7.277.527 0 1.04-.055 1.533-.16a.787.787 0 0 1 .81.316.733.733 0 0 1-.031.893A8.349 8.349 0 0 1 8.344 16C3.734 16 0 12.286 0 7.71 0 4.266 2.114 1.312 5.124.06A.752.752 0 0 1 6 .278z" />
                        </svg>

                        <svg id="sunSvg" class="hidden" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="black" class="bi bi-sun-fill" viewBox="0 0 16 16">
                            <path d="M8 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z" />
                        </svg>
                    </div>
                </div>
            </footer>

        </div>

    </div>

</div>

<script>

    // si tagsContainer n'est pas scrollable en y, pr-4
    if (document.getElementById('tagsContainer').scrollHeight <= document.getElementById('tagsContainer').clientHeight) {
        document.getElementById('tagsContainer').classList.add('md:pe-4');
    } else {
        document.getElementById('tagsContainer').classList.add('md:pe-[6px]');
    }

    // Scroll tags drag souris
    document.addEventListener('DOMContentLoaded', function() {
        const tagsContainer = document.querySelector('#tagsContainer');
        let isDown = false;
        let startX;
        let scrollLeft;

        tagsContainer.addEventListener('mousedown', (e) => {
            isDown = true;
            startX = e.pageX - tagsContainer.offsetLeft;
            scrollLeft = tagsContainer.scrollLeft;
        });

        tagsContainer.addEventListener('mouseleave', () => {
            isDown = false;
        });

        tagsContainer.addEventListener('mouseup', () => {
            isDown = false;
        });

        tagsContainer.addEventListener('mousemove', (e) => {
            if(!isDown) return;
            e.preventDefault();
            const x = e.pageX - tagsContainer.offsetLeft;
            const walk = (x - startX) * 1;
            tagsContainer.scrollLeft = scrollLeft - walk;
        });
    });
    
    if (document.getElementsByTagName('html')[0].classList.contains('dark')) {
        document.getElementById('moonSvg').classList.remove('hidden');
        document.getElementById('moonSvgSm').classList.remove('hidden');
        document.getElementById('sunSvg').classList.add('hidden');
        document.getElementById('sunSvgSm').classList.add('hidden');
    } else {
        document.getElementById('moonSvg').classList.add('hidden');
        document.getElementById('moonSvgSm').classList.add('hidden');
        document.getElementById('sunSvg').classList.remove('hidden');
        document.getElementById('sunSvgSm').classList.remove('hidden');
    }

    
function toggleThemeMode() {
        toggleThemeModeInBdd();
        document.getElementsByTagName('html')[0].classList.toggle('dark');
        document.getElementsByTagName('html')[0].classList.toggle('white');
        if (document.getElementsByTagName('html')[0].classList.contains('dark')) {
            document.getElementById('moonSvg').classList.remove('hidden');
            document.getElementById('moonSvgSm').classList.remove('hidden');
            document.getElementById('sunSvg').classList.add('hidden');
            document.getElementById('sunSvgSm').classList.add('hidden');
        } else {
            document.getElementById('moonSvg').classList.add('hidden');
            document.getElementById('moonSvgSm').classList.add('hidden');
            document.getElementById('sunSvg').classList.remove('hidden');
            document.getElementById('sunSvgSm').classList.remove('hidden');
        }
    }

function toggleThemeModeInBdd() {
    $.ajax({
        url: "/noteflow/toggleThemeMode",
        type: "POST",
        data: {
            theme: document.getElementsByTagName('html')[0].classList.contains('dark') ? 'dark' : 'white',
            idUser: <%= user.getIdUser() %>
        }
    });
}

function toggleOnlyFavParams(){
    // Toggle onlyFav params in url
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('onlyFav')) {
        urlParams.delete('onlyFav');
    } else {
        urlParams.append('onlyFav', true);
    }
    window.location.search = urlParams;
}

function toggleTagParams(idTag){
    // Toggle tag params in url
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('tag') && urlParams.get('tag') != idTag) {
        urlParams.delete('tag');
        urlParams.append('tag', idTag);
    } else if (urlParams.has('tag') && urlParams.get('tag') == idTag) {
        urlParams.delete('tag');
    } else {
        urlParams.append('tag', idTag);
    }
    window.location.search = urlParams;
}

document.getElementById('searchInput').addEventListener('keyup',searchNotesByTitle);

function searchNotesByTitle(){
    const searchInputValue = document.getElementById('searchInput').value;
    const notesTitle = document.getElementsByClassName('noteTitle');

    for (let i = 0; i < notesTitle.length; i++) {
        if(notesTitle[i].innerHTML.toLowerCase().includes(searchInputValue.toLowerCase())){
            notesTitle[i].parentElement.parentElement.parentElement.style.cssText = 'display: flex !important;';
        }else{
            notesTitle[i].parentElement.parentElement.parentElement.style.cssText = 'display: none !important;';
        }
    }
}

function showToastCreateTag(){
    const Toast = Swal.mixin({
                toast: true,
                customClass: {
                        popup: 'text-xs rounded-md border border-gray-300 shadow-lg p-4 bg-white',
                        confirmButton: 'bg-[#0F68A9] text-white',
                        cancelButton: 'bg-red-500 text-white',
                },
                position: 'top',
                width: 'fit-content',
		showConfirmButton: false,
		showCancelButton: false,
                timer: 0,
                timerProgressBar: true,
		didOpen: (toast) => {
			toast.addEventListener('mouseenter', Swal.stopTimer)
			toast.addEventListener('mouseleave', Swal.resumeTimer)
		}
        });

        Toast.fire({
                icon: 'info',
                title: 'Créer une étiquette',
                html: `
                        <form id="createTagForm" method="post">
                        <div class="flex flex-col gap-1">
                                <input type="text" id="newTagInput" name="newTagIndex" class="border border-gray-300 rounded-md p-2 mt-2 focus:outline-none" placeholder="Nouvelle étiquette" autocomplete="off">
                                <div class="flex items-center gap-2">
                                        <div class="text-sm">Couleur :</div>
                                        <input id="colorPicker" name="hex" type="color" class="rounded-md">
                                </div>
                        </div>
                        </form>
                `,
                showCancelButton: true,
		showConfirmButton: true,
                confirmButtonText: 'Créer',
                cancelButtonText: 'Annuler',
                }).then((result) => {
                if (result.isConfirmed) {
                        if(document.getElementById("newTagInput").value.length === 0 || document.getElementById("newTagInput").value === ""){
                                Toast.fire({
                                        icon: 'error',
                                        timer: 2000,
                                        title: 'Erreur',
                                        text: "Le nom de l'étiquette ne peut pas être vide"
                                });
                                return;
                        } else {
                                document.getElementById("createTagForm").submit();
                        }
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                        Toast.fire({
                                icon: 'error',
                                timer: 2000,
                                title: 'Annulée',
                                text: "L'étiquette n'a pas été créée"
                        });
                }
        });
}

function showToastCreateNote(){
    const Toast = Swal.mixin({
                toast: true,
                customClass: {
                        popup: 'text-xs rounded-md border border-gray-300 shadow-lg p-4 bg-white',
                        confirmButton: 'bg-[#0F68A9] text-white',
                        cancelButton: 'bg-red-500 text-white',
                },
                position: 'top',
                width: 'fit-content',
        showConfirmButton: false,
        showCancelButton: false,
                timer: 0,
                timerProgressBar: true,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer)
            toast.addEventListener('mouseleave', Swal.resumeTimer)
        }
        });

        Toast.fire({
                icon: 'info',
                title: 'Créer une note',
                html: `
                        <form id="createNoteForm" method="post">
                            <div class="flex flex-col gap-1">
                                    <input type="text" id="newNoteInput" name="newNoteIndex" class="border border-gray-300 rounded-md p-2 mt-2 focus:outline-none" placeholder="Nouvelle note" autocomplete="off">
                                    <%-- categories --%>
                                    <div class="flex items-center gap-2">
                                            <div class="text-sm">Catégorie :</div>
                                            <select name="idCategorie" class="rounded-md border border-gray-300 p-2 focus:outline-none">
                                                    <option value="0">Aucune</option>
                                                    <% for (Tag tagCreateNote : AllTagsUser) { %>
                                                            <option value="<%= tagCreateNote.getIdTag() %>"><%= tagCreateNote.getLibelle() %></option>
                                                    <% } %>
                                            </select>
                                    </div>
                            </div>
                        </form>
                `,
                showCancelButton: true,
                showConfirmButton: true,
                confirmButtonText: 'Créer',
                cancelButtonText: 'Annuler',
                }).then((result) => {
                if (result.isConfirmed) {
                        if(document.getElementById("newNoteInput").value.length === 0 || document.getElementById("newNoteInput").value === ""){
                                Toast.fire({
                                        icon: 'error',
                                        timer: 2000,
                                        title: 'Erreur',
                                        text: "Le nom de la note ne peut pas être vide"
                                });
                                return;
                        } else {
                                document.getElementById("createNoteForm").submit();
                        }
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                        Toast.fire({
                                icon: 'error',
                                timer: 2000,
                                title: 'Annulée',
                                text: "La note n'a pas été créée"
                        });
                }
        });
}
</script>