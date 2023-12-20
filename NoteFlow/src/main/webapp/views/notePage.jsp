<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.format.TextStyle" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.Tag" %>





<% ArrayList<Tag> tags = Controller.getUserTags(user.getIdUser()); %>

<% 
        ExtendedNote noteEdit = Controller.getNoteById(Integer.parseInt(request.getParameter("note")), user.getIdUser());
        Boolean isShared = false;
        if (noteEdit == null) {
                noteEdit = Controller.getNoteSharedById(Integer.parseInt(request.getParameter("note")), user.getIdUser());
                isShared = true;
        }

%>

<% if (noteEdit == null) { %>
        <%-- redirect to home page --%>
        <div class="w-full flex flex-col items-center justify-center h-screen bg-white">
                <div class="text-3xl font-bold">Note introuvable</div>
                <div class="text-xl">La note que vous cherchez n'existe pas, ou vous n'avez pas les droits pour la consulter</div>
                <div class="mt-4">
                        <a href="index.jsp?token=<%= request.getParameter("token") %>" class="bg-[#0F68A9] text-white px-4 py-2 rounded-md hover:bg-[#0F68A9] transition-all duration-500">Retour</a>
                </div>
        </div>
<% return;
} else { %>
        <%-- note found --%>
<% } %>


<div class="w-full h-full flex flex-col p-1 sm:p-12 sm:pt-6 transition-all duration-500 dark:bg-dark">

<% if (isShared) { %>
        <input type="hidden" id="permission" value="<%= Controller.getPermission(noteEdit.getIdNote(), user.getIdUser()) %>">
<% } else { %>
        <input type="hidden" id="permission" value="Modification">
<% } %>

<div class="flex items-center justify-between">
        <div class="flex items-center gap-2">
                <svg onclick="goBack()" xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-arrow-left-short hover:cursor-pointer dark:fill-white" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M12 8a.5.5 0 0 1-.5.5H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5a.5.5 0 0 1 .5.5"/>
                </svg>

                <% if (!isShared) { %>
                        <svg id="shareButton" xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-arrow-left-short hover:cursor-pointer dark:fill-white" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M11 2.5a2.5 2.5 0 1 1 .603 1.628l-6.718 3.12a2.499 2.499 0 0 1 0 1.504l6.718 3.12a2.5 2.5 0 1 1-.488.876l-6.718-3.12a2.5 2.5 0 1 1 0-3.256l6.718-3.12A2.5 2.5 0 0 1 11 2.5"/>
                        </svg>
                <% } %>
        </div>
        <div class="flex me-2 items-center">
                <div title="Sauvegarde en cours">
                        <svg id="savingIcon" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="hidden animate-spin bi bi-arrow-repeat dark:fill-white" viewBox="0 0 16 16">
                                <path d="M11.534 7h3.932a.25.25 0 0 1 .192.41l-1.966 2.36a.25.25 0 0 1-.384 0l-1.966-2.36a.25.25 0 0 1 .192-.41zm-11 2h3.932a.25.25 0 0 0 .192-.41L2.692 6.23a.25.25 0 0 0-.384 0L.342 8.59A.25.25 0 0 0 .534 9z"/>
                                <path fill-rule="evenodd" d="M8 3c-1.552 0-2.94.707-3.857 1.818a.5.5 0 1 1-.771-.636A6.002 6.002 0 0 1 13.917 7H12.9A5.002 5.002 0 0 0 8 3M3.1 9a5.002 5.002 0 0 0 8.757 2.182.5.5 0 1 1 .771.636A6.002 6.002 0 0 1 2.083 9z"/>
                        </svg>
                </div>
                <div title="Sauvegardé">
                        <svg id="savedSuccess" xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-check2 fill-green-500" viewBox="0 0 16 16">
                                <path d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z"/>
                        </svg>
                </div>
                <div title="Erreur lors de la sauvegarde">
                        <svg id="savedFail" xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="hidden bi bi-x fill-red-500" viewBox="0 0 16 16">
                                <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708"/>
                        </svg>
                </div>
        </div>
</div>


        <% if (!isShared) { %>
                <div class="transition-all duration-500 w-full h-[40px] rounded-t-md border-2 border-b-0 bg-white dark:border-gray-800 px-8 text-lg font-semibold flex items-center justify-between dark:bg-[<%= noteEdit.getHex() %>]/20 bg-[<%= noteEdit.getHex() %>]/20 dark:text-[<%= noteEdit.getHex() %>] text-[<%= noteEdit.getHex() %>]">
                        <div class="flex items-center gap-2">
                                <div>
                                        <%= noteEdit.getLibelle() %>
                                </div>
                                <div class="relative">
                                        <%-- chevron down to show menu --%>
                                        <svg id="chevronTag" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="mt-1 cursor-pointer bi bi-chevron-down transition-all duration-250" viewBox="0 0 16 16" onclick="document.getElementById('tagMenu').classList.toggle('hidden'); document.getElementById('chevronTag').classList.toggle('rotate-180');">
                                                <path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z"/>
                                        </svg>
                                        
                                        <%-- menu --%>
                                                <div id="tagMenu" class="hidden absolute z-10 bg-white dark:bg-darkNote dark:text-white border-2 border-gray-300 dark:border-gray-800 rounded-md shadow-lg py-1 text-sm min-w-[50px] max-h-[150px] overflow-y-auto">
                                                        <form method="POST" id="form-tag-<%= noteEdit.getIdNote() %>">
                                                                <input type="hidden" id="idTag" name="idTag" value="<%= noteEdit.getCategory() %>">
                                                                <% for (Tag tag : tags) {
                                                                        if (tag.getIdTag() != noteEdit.getCategory()) { %>
                                                                                <div class="flex items-center gap-2 px-2 py-1 hover:bg-gray-200 dark:hover:bg-gray-700 transition-all duration-500 cursor-pointer"                                                                  
                                                                                        onclick="document.getElementById('idTag').value = <%= tag.getIdTag() %>; document.getElementById('form-tag-<%= noteEdit.getIdNote() %>').submit()">
                                                                                        <label for="tag-<%= tag.getIdTag() %>" class="cursor-pointer px-2 text-sm text-[<%= tag.getHex() %>] dark:text-[<%= tag.getHex() %>]"><%= tag.getLibelle() %></label>
                                                                                </div>
                                                                <%   }
                                                                } %>
                                                        </form>
                                                        <%-- last div to add a tag --%>
                                                        <div class="flex items-center px-2 py-1 hover:bg-gray-200 dark:hover:bg-gray-700 transition-all duration-500 cursor-pointer" onclick="showToastAddTag()">
                                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="ms-2 bi bi-bookmark-plus-fill" viewBox="0 0 16 16">
                                                                        <path fill-rule="evenodd" d="M2 15.5V2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.74.439L8 13.069l-5.26 2.87A.5.5 0 0 1 2 15.5m6.5-11a.5.5 0 0 0-1 0V6H6a.5.5 0 0 0 0 1h1.5v1.5a.5.5 0 0 0 1 0V7H10a.5.5 0 0 0 0-1H8.5z"/>
                                                                </svg>
                                                                <label for="addTag" class="cursor-pointer pe-2 ps-1 text-sm text-green-500">Créer</label>
                                                        </div>
                                                </div>
                                </div>
                        </div>
                        <div class="cursor-pointer">
                                <form method="POST" id="form-favorite-<%= noteEdit.getIdNote() %>">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="grey" class="<%= noteEdit.getIsFavorite() == 1 ? "fill-yellow-500" : "fill-gray-500 dark:fill-gray-400 hover:fill-yellow-500" %> hover:duration-0 transition-all duration-500 bi bi-star-fill" viewBox="0 0 16 16" onclick="document.getElementById('form-favorite-<%= noteEdit.getIdNote() %>').submit()">
                                                <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                        </svg>
                                        <input type="hidden" name="idNoteToggleFavorite" value="<%= noteEdit.getIdNote() %>" id="idNoteToggleFavorite">
                                </form>
                        </div>
                </div>
        <% } %>
        <div class="dark:bg-darkNote dark:text-white px-8 bg-white border-2 border-b-0 dark:border-gray-800 transition-all duration-500 w-full h-[100px] overflow-hidden flex items-center justify-between gap-2 <%= isShared ? "border-t-2 rounded-t-md" : "border-t-0" %>">
                <div class="text-3xl max-w-[80%] w-[80%] font-bold">
                        <input onblur="handleInputBlur()" id="inputNoteTitle" type="text" class="w-full focus:outline-none text-ellipsis bg-transparent" value="<%= noteEdit.getTitle() %>">
                </div>
                <div class="w-[20%] flex justify-end">
                        <%-- timestamp jour mois année en français --%>
			<% 
				LocalDateTime timestamp = noteEdit.getTimestamp().toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
			%>
			<span class="text-sm line-clamp-2 text-ellipsis"><%= "Le " + timestamp.getDayOfMonth() + " " + timestamp.getMonth().getDisplayName(TextStyle.FULL, Locale.FRENCH) + " " + timestamp.getYear() + ", " + timestamp.getHour() + "h" + String.format("%02d", timestamp.getMinute()) %></span>
                </div>
        </div>
        <div id="editorjs" class="rounded-b-md dark:bg-darkNote dark:text-white bg-white border-2 border-t-0 dark:border-gray-800 transition-all duration-500 w-full h-full overflow-y-auto overflow-x-hidden"></div>
</div>


<script type="module" defer src="js/editor.js?v=5"></script>
<script>
function goBack() {
    const urlParams = new URLSearchParams(window.location.search);
    const token = urlParams.get('token');
    // redirect to home page
    window.location.href = "/noteflow?token=" + token;
}

document.getElementById("inputNoteTitle").addEventListener("keyup", function(event) {

        $.ajax({
            url: "/noteflow/renameNote",
            type: "POST",
            data: {
                titre: document.getElementById("inputNoteTitle").value.length > 0 ? document.getElementById("inputNoteTitle").value : "Sans titre",
                idNote: new URLSearchParams(window.location.search).get("note")
            }
        });
});

function handleInputBlur(){
        if(document.getElementById("inputNoteTitle").value.length === 0){
                document.getElementById("inputNoteTitle").value = "Sans titre";
        }
}

function showToastAddTag() {
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
                                <input type="text" id="newTagInput" name="newTag" class="border border-gray-300 rounded-md p-2 mt-2 focus:outline-none" placeholder="Nouvelle étiquette" autocomplete="off">
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

$("#shareButton").click(function() {
    loadCollegues()
});

function loadCollegues() {
    $.ajax({
        url: 'getColleguesAndShares', // URL of the server-side script that returns the collegues and shares
        type: 'GET',
        data: { 
                idUser: <%= user.getIdUser() %>,
                idNote: <%= noteEdit.getIdNote() %>
        },
        success: function(data) {
            // Show the share menu after the collegues and shares have been loaded
            showToastShareMenu();
            
            // data is an object with two properties: collegues and shares
            // Populate the select element with the collegues
            var selectUser = $("#selectUserPartage");
            $.each(data.collegues, function(index, collegue) {
                selectUser.append('<option value="' + collegue.id + '">' + collegue.prenom + ' ' + collegue.nom + '</option>');
            });
            // Populate the shares list with the existing shares
            var sharesList = $("#sharesList");
            $.each(data.shares, function(index, share) {
                sharesList.append(
                        '<form method="post">' +
                        '<input type="hidden" name="idShare" value="' + share.id + '">' +
                        '<li class="flex">' +
                        share.prenom + ' ' + share.nom + ' (' + share.permissions + ')' +
                        '<button type="submit">' +
                        '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash3-fill fill-red-500" viewBox="0 0 16 16">' +
                        '<path d="M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06Zm6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528ZM8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5"/>' +
                        '</svg>' +
                        '</button>' +
                        '</li>' +
                        '</form>'
                );
                });
        }
    });
}

function showToastShareMenu() {
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
    html: `
        <form id="shareForm" method="post">
            <div class="flex flex-col gap-1">
                <p class="text-sm">Partages existants :</p>
                <ul id="sharesList" class="mb-2"></ul>
                <p class="text-sm">Nouveau partage :</p>
                <select id="selectUserPartage" name="selectUserPartage" class="border border-gray-300 rounded-md p-2 mt-2 focus:outline-none">
                        <option selected value="">Choisir un collègue</option>
                </select>
                <select id="selectDroitPartage" name="selectDroitPartage" class="border border-gray-300 rounded-md p-2 mt-2 focus:outline-none">
                        <option selected value="">Choisir un droit</option>
                        <option value="Affichage">Affichage</option>
                        <option value="Modification">Modification</option>
                </select>
            </div>
        </form>
        <div id="sharesList">
            <!-- This will be filled with the existing shares by the loadCollegues function -->
        </div>
    `,
    showCancelButton: true,
    showConfirmButton: true,
    confirmButtonText: 'Partager',
    cancelButtonText: 'Annuler',
}).then((result) => {
    if (result.isConfirmed) {
        document.getElementById("shareForm").submit();
    } else if (result.dismiss === Swal.DismissReason.cancel) {
        Toast.fire({
            icon: 'error',
            timer: 2000,
            title: 'Annulée',
            text: "La note n'a pas été partagée"
        });
    }
});
}

</script>