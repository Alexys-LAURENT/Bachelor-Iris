<aside id="membersSection" class="lg:w-[20%] w-0 max-w-[100%] right-0 h-screen absolute lg:relative lg:block lg:bg-white bg-gray-50 overflow-hidden transition-all duration-500 border-s-2">
    <div class="h-[50px] flex justify-between items-center p-4 border-b-2">
        <p>Membres</p>

        <!-- close drawer btn -->
        <div class="block lg:hidden">
            <svg onclick="toggleMembers()" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
                <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z" />
            </svg>
        </div>
    </div>

    <!-- content -->
    <div class="flex flex-col items-center gap-4 relative">
        <div class="flex w-11/12 mt-3 justify-between">
            <input type="text" placeholder="Rechercher" class="rounded-md bg-gray-100 px-2 py-1 w-10/12 focus:outline-border cursor-text text-gray-600">
            <button onclick='handleShowFilter()' class="bg-secondary mx-2 rounded-md w-2/12 aspect-square flex justify-center items-center">
                <svg class="relative z-0" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="white" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
                    <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z" />
                </svg>
            </button>
            <div id="filterPopUp" class="max-h-0 transition-all overflow-hidden top-[53%] right-6  absolute max-w-[150px] rounded-md bg-white shadow z-10">
                <ul class="flex flex-col items-center">
                    <li class="flex items-center">
                        <input class="mt-[4px] me-1 cursor-pointer" type="checkbox" name="" id="checkbox-0">
                        <label class="select-none cursor-pointer" for="checkbox-0">Métier 1</label>
                    </li>
                    <li class="flex items-center">
                        <input class="mt-[4px] me-1 cursor-pointer" type="checkbox" name="" id="checkbox-1">
                        <label class="select-none cursor-pointer" for="checkbox-1">Métier 2</label>
                    </li>
                    <li class="flex items-center">
                        <input class="mt-[4px] me-1 cursor-pointer" type="checkbox" name="" id="checkbox-2">
                        <label class="select-none cursor-pointer" for="checkbox-2">Métier 3</label>
                    </li>
                    <li class="flex items-center">
                        <input class="mt-[4px] me-1 cursor-pointer" type="checkbox" name="" id="checkbox-3">
                        <label class="select-none cursor-pointer" for="checkbox-3">Métier 4</label>
                    </li>
                    <li class="flex items-center">
                        <input class="mt-[4px] me-1 cursor-pointer" type="checkbox" name="" id="checkbox-4">
                        <label class="select-none cursor-pointer" for="checkbox-4">Métier 5</label>
                    </li>
                    <button class="text-sm bg-secondary text-white mt-1 rounded-md px-3 py-1">Filtrer</button>
                </ul>
            </div>
        </div>
        <!-- Members -->
        <div class="w-full flex flex-col gap-2">
            <!-- Contact row -->
            <div class="flex max-w-full mx-4 gap-2">
                <div class="aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]"></div>
                <div class="flex flex-col">
                    <p class="font-semibold w-full text-elipsis line-clamp-1">Louise Martine </p>
                    <span class="w-full line-clamp-1 text-elipsis text-gray-500 text-xs relative top-[-3px]">Designeuse Web</span>
                </div>
            </div>


        </div>

    </div>
</aside>