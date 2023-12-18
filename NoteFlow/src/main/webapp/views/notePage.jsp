<%@ page import="java.time.format.TextStyle" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.ZoneId" %>

<% ExtendedNote noteEdit = Controller.getNoteById(Integer.parseInt(request.getParameter("note"))); %>

<%
    if(request.getParameter("idNoteToggleFavorite") != null){
        int idNoteToggleFavorite = Integer.parseInt(request.getParameter("idNoteToggleFavorite"));
        Controller.toggleFavorite(idNoteToggleFavorite);
        // refresh
        response.sendRedirect("index.jsp" + (request.getParameter("token") != null ? "?token=" + request.getParameter("token") : "") + (request.getParameter("note") != null ? "&note=" + request.getParameter("note") : ""));
    }
%>

<div class="w-full h-full flex flex-col p-12 pt-6 transition-all duration-500 dark:bg-dark">

<svg onclick="goBack()" xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-arrow-left-short hover:cursor-pointer" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M12 8a.5.5 0 0 1-.5.5H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5a.5.5 0 0 1 .5.5"/>
</svg>

        <div class="transition-all duration-500 w-full h-[40px] rounded-t-md border-2 border-b-0 bg-white dark:border-gray-800 px-8 text-lg font-semibold flex items-center justify-between bg-[<%= noteEdit.getHex() %>]/10 dark:text-[<%= noteEdit.getHex() %>] text-[<%= noteEdit.getHex() %>]">
                <div>
                        <%= noteEdit.getLibelle() %>
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
                        <input onblur="handleInputBlur()" id="inputNoteTitle" type="text" class="w-full focus:outline-none text-ellipsis" value="<%= noteEdit.getTitle() %>">
                </div>
                <div class="w-[20%] flex justify-end">
                        <%-- timestamp jour mois année zn français --%>
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

</script>