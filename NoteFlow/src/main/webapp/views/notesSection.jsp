<div class="w-full h-full flex p-4">
        
           <% ArrayList<ExtendedNote> notes = Controller.getAllNotes();   %>
        
        
        <div class="flex flex-wrap gap-8 justify-center md:justify-normal">
           <% for(ExtendedNote note : notes){  %>
				
				<div class="flex flex-col relative w-full md:w-[450px] h-[220px] bg-white shadow rounded-md px-4 hover:cursor-pointer hover:scale-[1.03] transition-all hover:shadow-xl hover:border-[1px] hover:border-gray-200">
					<span class="absolute w-[4px] h-[45px] bg-[<%= note.getHex() %>] left-0 top-[15px]"></span>
					<div class="flex w-full h-[40px] mt-[20px] items-center" ><p class="font-semibold max-w-full overflow-hidden text-ellipsis line-clamp-1 text-base md:text-xl"><%= note.getTitle() %></p><span class="w-4 h-4 min-w-4 min-h-4 rounded-full flex ms-2 bg-[<%= note.getHex() %>] <%= note.getTitle().length() >= 38 ? "hidden" : "hidden md:flex"  %>"></span></div>
					<div class="flex max-w-full h-[130px] max-h-[130px] overflow-hidden"><p class="max-h-[115px] md:max-h-[120px] text-ellipsis text-xs md:text-base line-clamp-[7] md:line-clamp-5"><%= note.getContent() %></p></div>
					<div class="flex w-full h-[30px] items-center justify-end "><div class="px-2 py-[2px] min-w-[100px] rounded-full flex justify-center items-center bg-[<%= note.getHex() %>] bg-opacity-10"><span class="text-xs font-semibold text-[<%= note.getHex() %>]"><%= note.getLibelle() %></span></div></div>
				</div>
				
           <%  } %>
        </div>

       
</div>