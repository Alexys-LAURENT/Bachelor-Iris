<div class="w-full h-full flex p-4 overflow-y-auto overflow-x-hidden justify-center">
        
           <% ArrayList<ExtendedNote> notes = Controller.getAllNotes();   %>
        
        
        <div class="flex flex-wrap w-full gap-4 xl:gap-8 justify-center 2xl:justify-start content-start">
           <% for(ExtendedNote note : notes){  %>
				
				<a href="index.jsp?note=<%= note.getIdNote() %>" class="flex flex-col relative w-full md:w-[50%] h-[220px] bg-white shadow rounded-md px-4 hover:cursor-pointer hover:scale-[1.005] transition-all hover:shadow-xl hover:border-[1px] hover:border-gray-200 flex-1-1">
					<span class="absolute w-[4px] h-[45px] bg-[<%= note.getHex() %>] left-0 top-[15px]"></span>
					<div class="flex w-full h-[40px] mt-[20px] items-center" ><p class="font-semibold max-w-full overflow-hidden text-ellipsis line-clamp-1 text-base md:text-xl"><%= note.getTitle() %></p><span class="w-4 h-4 min-w-4 min-h-4 rounded-full flex ms-2 bg-[<%= note.getHex() %>] <%= note.getTitle().length() >= 38 ? "hidden" : "hidden md:flex"  %>"></span></div>
					<div class="flex max-w-full h-[130px] max-h-[130px] overflow-hidden"><p class="max-h-[115px] md:max-h-[120px] text-ellipsis text-xs md:text-base line-clamp-[7] md:line-clamp-5"><%= note.getContent() %></p></div>
					<div class="flex w-full h-[50px] items-center justify-between ">
						<span class="flex gap-2">
						<form method="POST" id="form-favorite-<%= note.getIdNote() %>">
							<svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" fill="grey" class="<%= note.getIsFavorite() == 1 ? "fill-yellow-500 hover:fill-gray-500" : "fill-gray-500 hover:fill-yellow-500" %> bi bi-star-fill" viewBox="0 0 16 16" onclick="document.getElementById('form-favorite-<%= note.getIdNote() %>').submit()">
	  							<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
							</svg>
							<input type="hidden" name="idNoteToggleFavorite" value="<%= note.getIdNote() %>">
						</form>
						<form method="POST" id="form-delete-<%= note.getIdNote() %>">
							<svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" fill="black" class="hover:fill-red-500 bi bi-trash3-fill" viewBox="0 0 16 16" onclick="document.getElementById('form-delete-<%= note.getIdNote() %>').submit()">
						  		<path d="M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06Zm6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528ZM8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5"/>
							</svg>
							<input type="hidden" name="idNoteDelete" value="<%= note.getIdNote() %>">
						</form>
						</span>
						<div class="px-2 py-[2px] min-w-[100px] rounded-full flex justify-center items-center bg-[<%= note.getHex() %>] bg-opacity-10">
							<span class="text-xs font-semibold text-[<%= note.getHex() %>]"><%= note.getLibelle() %></span>
						</div>
					</div>
				</a>
				
           <%  } %>
           
           <p>test</p>
        </div>
</div>

<%
	if(request.getParameter("idNoteToggleFavorite") != null){
		int idNoteToggleFavorite = Integer.parseInt(request.getParameter("idNoteToggleFavorite"));
		Controller.toggleFavorite(idNoteToggleFavorite);
		response.sendRedirect("index.jsp");
	}

	if(request.getParameter("idNoteDelete") != null){
		int idNoteDelete = Integer.parseInt(request.getParameter("idNoteDelete"));
		Controller.delete(idNoteDelete);
		response.sendRedirect("index.jsp");
	}
%>