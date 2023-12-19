<%@ page import="java.time.format.TextStyle" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.ZoneId" %>
<%
ArrayList<ExtendedNote> notes;
if(request.getParameter("tag") != null){
	String tag = request.getParameter("tag");
	// pass the user id with user.getIdUser() wich is a number as a string
	notes = Controller.getAllNotes(tag, user.getIdUser());
}else{
	notes = Controller.getAllNotes("null", user.getIdUser());
}
if(request.getParameter("onlyFav") != null && "true".equals(request.getParameter("onlyFav"))){
	notes = Controller.returnFavNotes(notes);
}
%>

<div class="w-full md:h-full md:min-h-0 flex p-4 md:overflow-y-auto md:overflow-x-hidden justify-center transition-all duration-500 bg-white dark:bg-dark dark:text-white">
        
        
        
        <div class="flex flex-wrap w-full gap-4 xl:gap-8 justify-center 2xl:justify-start content-start">
           <% for(ExtendedNote note : notes){  %>
				
				<div class="flex flex-col relative w-full md:w-[1%] h-[300px] shadow rounded-md px-4 hover:cursor-pointer hover:scale-[1.005] hover:shadow-xl dark:shadow-gray-800 hover:border-[1px] hover:border-gray-200 flex-1-1 bg-white dark:bg-darkNote text-black dark:text-white transition-all duration-500">
				<a href="index.jsp?token=<%= request.getParameter("token") %>&note=<%= note.getIdNote() %>">
					<span class="absolute w-[4px] h-[45px] bg-[<%= note.getHex() %>] left-0 top-[15px]"></span>
					<div class="flex w-full h-[40px] items-center pt-4">
						<p class="noteTitle font-semibold max-w-full overflow-hidden text-ellipsis line-clamp-1 text-base md:text-xl">
							<%= note.getTitle() %>
						</p>
						<span class="mt-[5px] w-4 h-4 min-w-4 min-h-4 rounded-full flex ms-2 bg-[<%= note.getHex() %>] <%= note.getTitle().length() >= 38 ? "hidden" : "hidden md:flex"  %>"></span>
					</div>
					<div class="flex flex-col max-w-full h-[210px] overflow-hidden">
						<p class="min-h-[20px] md:min-h-[15px] text-ellipsis text-2xs md:text-xs line-clamp-[7] md:line-clamp-5">
							<%-- timestamp jour mois annï¿½e zn franï¿½ais --%>
							<% 
								LocalDateTime timestamp = note.getTimestamp().toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
							%>
							<%= timestamp.getDayOfMonth() + " " + timestamp.getMonth().getDisplayName(TextStyle.FULL, Locale.FRENCH) + " " + timestamp.getYear() %>
						</p>
						<div id="notePreview<%= note.getIdNote() %>" class="flex-col gap-[20px] text-sm md:text-base pt-5 previewNote pointer-events-none select-none flex" tabindex="-1">
							<div class="rounded-md p-2 w-full mx-auto">
								<div class="animate-pulse flex space-x-4">
									<div class="flex-1 space-y-6 py-1">
										<div class="h-2 bg-slate-700 rounded"></div>
										<div class="space-y-3">
											<div class="grid grid-cols-3 gap-4">
												<div class="h-2 bg-slate-700 rounded col-span-2"></div>
												<div class="h-2 bg-slate-700 rounded col-span-1"></div>
											</div>
											<div class="h-2 bg-slate-700 rounded"></div>
											<div class="h-2 bg-slate-700 rounded"></div>
											<div class="grid grid-cols-3 gap-4">
												<div class="h-2 bg-slate-700 rounded col-span-1"></div>
												<div class="h-2 bg-slate-700 rounded col-span-2"></div>
											</div>
										</div>
										<div class="h-2 bg-slate-700 rounded"></div>
										<div class="h-2 bg-slate-700 rounded"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="flex w-full h-[50px] items-center justify-end text-white dark:text-black transition-all duration-500 ">
						<div class="px-2 py-[2px] min-w-[100px] rounded-full flex justify-center items-center bg-[<%= note.getHex() %>]/50 dark:bg-[<%= note.getHex() %>]/10 dark:bg-opacity-10 bg-opacity-50 transition-all duration-500">
							<span class="text-xs font-semibold text-[<%= note.getHex() %>] transition-all duration-500">
								<%= note.getLibelle() %>
							</span>
						</div>
					</div>
				</a>
				<span class="flex gap-2 z-50 absolute bottom-5">
						<form method="POST" id="form-favorite-<%= note.getIdNote() %>">
							<svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" fill="grey" class="<%= note.getIsFavorite() == 1 ? "fill-yellow-500" : "fill-gray-500 hover:fill-yellow-500" %> hover:duration-0 transition-all duration-500 bi bi-star-fill" viewBox="0 0 16 16" onclick="document.getElementById('form-favorite-<%= note.getIdNote() %>').submit()">
	  							<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
							</svg>
							<input type="hidden" name="idNoteToggleFavoriteIndex" value="<%= note.getIdNote() %>" id="idNoteToggleFavorite2">
						</form>
						<form method="POST" id="form-delete-<%= note.getIdNote() %>">
							<svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" fill="black" class="hover:fill-red-500 dark:hover:fill-red-500 dark:fill-white bi bi-trash3-fill hover:duration-0 transition-all duration-500" viewBox="0 0 16 16" onclick="showToastDelete(<%= note.getIdNote() %>, '<%= note.getTitle() %>')">
						  		<path d="M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06Zm6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528ZM8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5"/>
							</svg>
							<input type="hidden" name="idNoteDelete" value="<%= note.getIdNote() %>" id="idNoteDelete">
						</form>
					</span>
				</div>
				
           <%  } %>
        </div>
</div>

<script src="js/previewNote.js?v=7"></script>
<script defer>
		<% for (ExtendedNote note : notes) { %>
			// Preview note with keys id and content in single array
			handlePreview(
				{ id: <%= note.getIdNote() %>, content: <%= note.getContent().length() > 0 ? note.getContent() : "''" %> },
			);
		<% } %>

</script>
<script>

		// Show toast when deleting a note
		function showToastDelete(idNote, title) {
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
				icon: 'warning',
				title: 'Êtes-vous sûr?',
				text: "Vous ne pourrez pas revenir en arrière!",
				showCancelButton: true,
				showConfirmButton: true,
				confirmButtonText: "Oui, supprimer!",
				cancelButtonText: "Non, annuler!",
				reverseButtons: true
			}).then((result) => {
				if (result.isConfirmed) {
						// Delete note
						localStorage.setItem('showConfirmation', true);
						document.getElementById('form-delete-' + idNote).submit();
				} else if (result.dismiss === Swal.DismissReason.cancel) {
					Toast.fire({
						icon: 'error',
						timer: 2000,
						title: 'Annulée',
						text: "La note n'a pas été supprimée."
					});
				}
			});
		}

		// Show toast after deleting a note
		function showToastConfirmDelete(title, text) {
			const Toast = Swal.mixin({
				toast: true,
				customClass: {
					popup: 'text-xs rounded-md border border-gray-300 shadow-lg p-4 bg-white',
				},
				position: 'top',
				timer: 2000,
				width: 'fit-content',
				timerProgressBar: true,
				showConfirmButton: false,
				didOpen: (toast) => {
					toast.addEventListener('mouseenter', Swal.stopTimer)
					toast.addEventListener('mouseleave', Swal.resumeTimer)
				}
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
		if (showConfirmation) {
			localStorage.removeItem('showConfirmation');
			showToastConfirmDelete("Supprimée", "La note a bien été supprimée.");
		}
	</script>