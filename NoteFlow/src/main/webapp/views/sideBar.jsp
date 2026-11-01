<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- get all user Tags --%>

<%
    ArrayList<Tag> AllTagsUser = Controller.getUserTags(user.getIdUser());
%>

<% if (request.getParameter("deleteTagSelect") != null) {
    Controller.deleteTag(Integer.parseInt(request.getParameter("deleteTagSelect")));
    // refresh page
    response.sendRedirect("index.jsp" + (request.getParameter("token") != null ? "?token=" + request.getParameter("token") : ""));
} %>

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
        <div id="tagsWrapper" class="flex md:flex-col h-full relative scroll-shadow-s after:transition-colors after:duration-500">
            <div id="tagsContainer"
                class="tagsContainer relative flex hide-scrollbar md:flex-col md:items-center min-h-[10px] h-full overflow-x-auto overflow-y-hidden md:overflow-x-hidden md:overflow-y-auto gap-2 py-2 w-full md:ps-4 md:mx-0 mx-4">
                <%-- Favoris --%>
                <div onclick="toggleOnlyFavParams()"
                    class="md:min-h-[32px] min-[26px] mb-0 md:mb-3 text-xs px-2 py-1 bg-[#FFF5E5] flex w-fit rounded-md md:w-full md:justify-center md:max-w-full md:text-base md:py-1 md:font-semibold cursor-pointer select-none <%= request.getParameter("onlyFav") != null && "true".equals(request.getParameter("onlyFav")) ? "outline outline-[2.5px] outline-[#F18600]" : "" %>">
                    <p class="whitespace-nowrap text-[#F18600]">Favoris</p>
                </div>

                <%-- Partagées avec moi --%>
                <div onclick="toggleSharedWithMeParams()"
                    class="md:min-h-[32px] min-[26px] mb-0 md:mb-3 text-xs px-2 py-1 bg-[#8eb9fb] flex w-fit rounded-md md:w-full md:justify-center md:max-w-full md:text-base md:py-1 md:font-semibold cursor-pointer select-none <%= request.getParameter("sharedWithMe") != null && "true".equals(request.getParameter("sharedWithMe")) ? "outline outline-[2.5px] outline-[#0e79ff]" : "" %>">
                    <p class="whitespace-nowrap text-[#0e79ff]">Partagées avec moi</p>
                </div>

                <%-- Tags --%>
                <% for (Tag tag : AllTagsUser) { %>
                <div onclick="toggleTagParams(<%= tag.getIdTag() %>)"
                    class="md:min-h-[32px] min-[26px] text-xs px-2 py-1 dark:bg-[<%= tag.getHex() %>]/20 bg-[<%= tag.getHex() %>]/20 flex w-fit rounded-md md:w-full md:justify-center md:max-w-full md:text-base md:py-1 md:font-semibold cursor-pointer select-none outline-[<%= tag.getHex() %>] <%= request.getParameter("tag") != null && request.getParameter("tag").equals(String.valueOf(tag.getIdTag())) ? "outline outline-[2.5px]" : "" %>">
                    <p class="whitespace-nowrap text-[<%= tag.getHex() %>]"><%= tag.getLibelle() %></p>
                </div>
                <% } %>

                <%-- Add and edit tags --%>
                <div class="flex gap-2 items-center w-fit md:w-full md:mt-2 sticky bottom-0">
                    <div onclick="showToastCreateTag()"
                        class="md:min-h-[32px] min-[26px] md:min-h-[34px] text-xs px-2 py-1 dark:bg-darkNote bg-white flex  rounded-md md:w-full justify-center md:py-1 md:font-semibold cursor-pointer select-none border border-green-500 transition-colors duration-500">
                        <p class="flex items-center">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="md:h-6 md:w-6 bi bi-plus fill-green-500" viewBox="0 0 16 16">
                                <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
                            </svg>
                        </p>
                    </div>
                    <div onclick="showToastEditTag()"
                        class="md:min-h-[32px] min-[26px] md:min-h-[34px] text-xs px-2 py-1 dark:bg-darkNote bg-white flex w-fit rounded-md md:w-full justify-center md:py-1 md:font-semibold cursor-pointer select-none border border-orange-500 transition-colors duration-500">
                        <p class="flex items-center">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="h-3 w-3 md:h-4 md:w-4 bi bi-pencil fill-orange-500" viewBox="0 0 16 16">
                                <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
                            </svg>
                        </p>
                    </div>
                    <div onclick="showToastDeleteTag()"
                        class="md:min-h-[32px] min-[26px] md:min-h-[34px] text-xs px-2 py-1 dark:bg-darkNote bg-white flex w-fit rounded-md md:w-full justify-center md:py-1 md:font-semibold cursor-pointer select-none border border-red-500 transition-colors duration-500">
                        <p class="flex items-center">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash3-fill fill-red-500" viewBox="0 0 16 16">
                                <path d="M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06Zm6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528ZM8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5"/>
                            </svg>
                        </p>
                    </div>
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
        if (urlParams.has('sharedWithMe')) {
            urlParams.delete('sharedWithMe');
        }
        urlParams.append('onlyFav', true);
    }
    window.location.search = urlParams;
}

function toggleTagParams(idTag){
    // Toggle tag params in url
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('sharedWithMe')) {
        urlParams.delete('sharedWithMe');
    }
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

function toggleSharedWithMeParams(){
    // Toggle sharedWithMe params in url
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('sharedWithMe')) {
        urlParams.delete('sharedWithMe');
    } else {
        if (urlParams.has('onlyFav')) {
            urlParams.delete('onlyFav');
        }
        if (urlParams.has('tag')) {
            urlParams.delete('tag');
        }
        urlParams.append('sharedWithMe', true);
    }
    window.location.search = urlParams;
}

document.getElementById('searchInput').addEventListener('keyup',searchNotesByTitle);

function searchNotesByTitle(){
    const searchInputValue = document.getElementById('searchInput').value;
    const notesTitle = document.getElementsByClassName('noteTitle');

    for (let i = 0; i < notesTitle.length; i++) {
        if(notesTitle[i].innerHTML.toLowerCase().includes(searchInputValue.toLowerCase())){
            notesTitle[i].parentElement.parentElement.parentElement.parentElement.style.cssText = 'display: flex !important;';
        }else{
            notesTitle[i].parentElement.parentElement.parentElement.parentElement.style.cssText = 'display: none !important;';
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
		showConfirmButton: false,
		showCancelButton: false,
                timer: 0,
                timerProgressBar: true
        });

        Toast.fire({
                icon: 'info',
                title: 'Créer une étiquette',
                html: `
                        <form id="createTagForm" method="post">
                        <div class="flex flex-col gap-1">
                                <div class="relative">
                                    <input type="text" id="newTagInput" name="newTagIndex" class="w-full border border-gray-300 rounded-md p-2 mt-2 focus:outline-none" placeholder="Nouvelle étiquette" autocomplete="off" onkeyup="document.getElementById('charCounterCreate').innerHTML = this.value.length + '/20';" maxlength="20">
                                    <span id="charCounterCreate" class="absolute bottom-0 right-1 text-3xs text-gray-400">0/20</span>
                                </div>
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
                        } else if (document.getElementById("newTagInput").value.length > 20) {
                                Toast.fire({
                                        icon: 'error',
                                        timer: 2000,
                                        title: 'Erreur',
                                        text: "Le nom de l'étiquette ne peut pas dépasser 20 caractères"
                                });
                                return;
                        } else {
                                localStorage.setItem("showConfirmation", "CreateTag");
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

function showToastEditTag(){
    const Toast = Swal.mixin({
        toast: true,
        customClass: {
            popup: 'text-xs rounded-md border border-gray-300 shadow-lg p-4 bg-white',
            confirmButton: 'bg-[#0F68A9] text-white',
            cancelButton: 'bg-red-500 text-white',
        },
        position: 'top',
        showConfirmButton: false,                   
        showCancelButton: false,
        timer: 0,
        timerProgressBar: true
    });

    Toast.fire({
        icon: 'info',
        title: 'Modifier une étiquette',
        html: `
            <form id="editTagForm" method="post">
            <div class="flex flex-col gap-1">
                <select id="editTagSelect" name="editTagSelect" class="border border-gray-300 rounded-md p-2 mt-2 focus:outline-none" onchange="
                    document.getElementById('NewTagHex').value = this.options[this.selectedIndex].getAttribute('data-hex');
                ">
                    <option value="0">Choisir une étiquette</option>
                    <% for (Tag tagEdit : AllTagsUser) { %>
                        <option value="<%= tagEdit.getIdTag() %>" data-hex="<%= tagEdit.getHex() %>"><%= tagEdit.getLibelle() %></option>
                    <% } %>
                </select>
                <div class="relative">
                <input type="text" id="NewTagName" name="NewTagName" class="w-full border border-gray-300 rounded-md p-2 mt-2 focus:outline-none" placeholder="Nouveau nom" autocomplete="off" onkeyup="document.getElementById('charCounterUpdate').innerHTML = this.value.length + '/20';" maxlength="20">
                    <span id="charCounterUpdate" class="absolute bottom-0 right-1 text-3xs text-gray-400">0/20</span>
                </div>
                <div class="flex items-center gap-2">
                    <div class="text-sm">Couleur :</div>
                    <input id="NewTagHex" name="NewTagHex" type="color" class="rounded-md">
                </div>
            </div>
            </form>
        `,
        showCancelButton: true,
        showConfirmButton: true,
        confirmButtonText: 'Modifier',
        cancelButtonText: 'Annuler',
    }).then((result) => {
        if (result.isConfirmed) {
            if (document.getElementById("editTagSelect").value === "0"){
                Toast.fire({
                    icon: 'error',
                    timer: 2000,
                    title: 'Erreur',
                    text: "Vous devez choisir une étiquette"
                });
                return;
            } else if (document.getElementById("NewTagName").value.length === 0 || document.getElementById("NewTagName").value === ""){
                Toast.fire({
                    icon: 'error',
                    timer: 2000,
                    title: 'Erreur',
                    text: "Le nom de l'étiquette ne peut pas être vide"
                });
                return;
            } else if (document.getElementById("NewTagName").value.length > 20) {
                Toast.fire({
                    icon: 'error',
                    timer: 2000,
                    title: 'Erreur',
                    text: "Le nom de l'étiquette ne peut pas dépasser 20 caractères"
                });
                return;
            } else {
                localStorage.setItem("showConfirmation", "EditTag");
                document.getElementById("editTagForm").submit();
            }
        } else if (result.dismiss === Swal.DismissReason.cancel) {
            Toast.fire({
                icon: 'error',
                timer: 2000,
                title: 'Annulée',
                text: "L'étiquette n'a pas été modifiée"
            });
        }
    });
}

function showToastDeleteTag(){
    const Toast = Swal.mixin({
        toast: true,
        customClass: {
            popup: 'text-xs rounded-md border border-gray-300 shadow-lg p-4 bg-white',
            confirmButton: 'bg-[#0F68A9] text-white',
            cancelButton: 'bg-red-500 text-white',
        },
        position: 'top',
        showConfirmButton: false,                   
        showCancelButton: false,
        timer: 0,
        timerProgressBar: true
    });

    Toast.fire({
        icon: 'info',
        title: 'Supprimer une étiquette',
        html: `
            <form id="deleteTagForm" method="post">
            <div class="flex flex-col gap-1">
                <div class="text-xs text-red-500">Toutes les notes associées à cette étiquette se retrouveront sans étiquette</div>
                <select id="deleteTagSelect" name="deleteTagSelect" class="border border-gray-300 rounded-md p-2 mt-2 focus:outline-none">
                    <option value="0">Choisir une étiquette</option>
                    <% for (Tag tagDelete : AllTagsUser) { %>
                        <option value="<%= tagDelete.getIdTag() %>"><%= tagDelete.getLibelle() %></option>
                    <% } %>
                </select>
            </div>
            </form>
        `,
        showCancelButton: true,
        showConfirmButton: true,
        confirmButtonText: 'Supprimer',
        cancelButtonText: 'Annuler',
    }).then((result) => {
        if (result.isConfirmed) {
            localStorage.setItem("showConfirmation", "DeleteTag");
            document.getElementById("deleteTagForm").submit();
        } else if (result.dismiss === Swal.DismissReason.cancel) {
            Toast.fire({
                icon: 'error',
                timer: 2000,
                title: 'Annulée',
                text: "L'étiquette n'a pas été supprimée"
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
                showConfirmButton: false,
                showCancelButton: false,
                timer: 0,
                timerProgressBar: true
        });

        Toast.fire({
                icon: 'info',
                title: 'Créer une note',
                html: `
                        <form id="createNoteForm" method="post">
                            <div class="flex flex-col gap-1">
                                    <input type="text" id="newNoteInput" name="newNoteIndex" class="border border-gray-300 rounded-md p-2 mt-2 focus:outline-none" placeholder="Titre de la note" autocomplete="off">
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
                                document.getElementById("newNoteInput").value = "Sans titre";
                                document.getElementById("createNoteForm").submit();
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



// Show toast after performing action
function showToastConfirmCreateTag(title, text){
    const Toast = Swal.mixin({
        toast: true,
        customClass: {
            popup: 'text-xs rounded-md border border-gray-300 shadow-lg p-4 bg-white',
        },
        position: 'top',
        timer: 2000,
        timerProgressBar: true,
		showConfirmButton: false
    });

    Toast.fire({
        icon: 'success',
		title: title,
		text: text,
		showConfirmButton: false,
    });
}

// Check if confirmation message should be shown
const showConfirmation = localStorage.getItem('showConfirmation');
if (showConfirmation === "CreateTag") {
    showToastConfirmCreateTag("Succès", "L'étiquette a bien été créée");
    localStorage.removeItem('showConfirmation');
} else if (showConfirmation === "EditTag") {
    showToastConfirmCreateTag("Succès", "L'étiquette a bien été modifiée");
    localStorage.removeItem('showConfirmation');
} else if (showConfirmation === "DeleteTag") {
    showToastConfirmCreateTag("Succès", "L'étiquette a bien été supprimée");
    localStorage.removeItem('showConfirmation');
}

</script>