<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.format.TextStyle" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.Tag" %>


<% ExtendedNote noteEdit = Controller.getNoteById(Integer.parseInt(request.getParameter("note"))); %>

<% ArrayList<Tag> tags = Controller.getUserTags(user.getIdUser()); %>


<div class="w-full h-full flex flex-col p-1 sm:p-12 sm:pt-6 transition-all duration-500 dark:bg-dark">

<svg onclick="goBack()" xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-arrow-left-short hover:cursor-pointer dark:fill-white" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M12 8a.5.5 0 0 1-.5.5H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5a.5.5 0 0 1 .5.5"/>
</svg>

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
        <div class="dark:bg-darkNote dark:text-white px-8 bg-white border-2 border-t-0 border-b-0 dark:border-gray-800 transition-all duration-500 w-full h-[100px] overflow-hidden flex items-center justify-between gap-2">
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


<script type="module" defer src="js/editor.js?v=2"></script>
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

</script>