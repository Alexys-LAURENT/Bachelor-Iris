<aside id="membersSection" class="lg:w-[16%] w-0 max-w-[100%] right-0 h-screen absolute lg:relative lg:block lg:bg-white bg-gray-50 overflow-hidden transition-all duration-500 border-s-2">
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
    <div class="flex flex-col items-center">

        <input type="text" placeholder="test" class="rounded-md bg-gray-100 px-2 py-1 focus:outline-border cursor-text mt-3 w-11/12 text-gray-600">

        <!-- categorie -->
        <div class="w-full flex flex-col flex-start bg-green-100">
            <!-- Contact row -->
            <div onclick="handleShow('section-0')">
                <h3>Développeurs webs :</h3>
                <div id="section-0" class="h-0 overflow-hidden">
                    <div>
                        <p>test</p>
                    </div>
                </div>
            </div>

        </div>

    </div>
</aside>