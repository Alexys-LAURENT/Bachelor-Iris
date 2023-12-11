<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<div
    class="flex flex-col md:bg-white w-full md:w-2/12 md:min-w-[250px] md:max-w-[250px] md:h-screen  overflow-x-hidden pt-2 gap-4 ">

    <!-- Title -->
    <div class="flex justify-between px-4">
        <h1 class="text-xl">Mes notes</h1>
        <div class="avatar md:hidden w-8 h-8 rounded-full bg-gray-500"></div>
    </div>

    <!-- Search input -->
    <div class="px-4">
        <input type="text" class="w-full bg-white  border rounded-md h-9 focus:outline-none px-2"
            placeholder="Rechercher une note" name="" id="">
    </div>

    <div class="h-full overflow-hidden">
        <div class="flex md:flex-col h-full relative scroll-shadow-s" id="tagsWrapper">
            <div id="tagsContainer"
                class="tagsContainer relative flex hide-scrollbar md:flex-col md:items-center h-full overflow-auto gap-2 py-2 w-full md:ps-4 md:pe-[6px] md:mx-0 mx-4">
                <!-- Tags -->
                <div
                    class="text-xs px-2 py-1 bg-red-100 flex w-fit rounded-md md:w-full md:justify-center md:max-w-full md:text-base md:py-1 md:font-semibold">
                    <p class="text-[#E95830]">Favoris</p>
                </div>

            </div>

            <!-- footer -->
            <footer
                class="hidden md:flex w-full h-[68px] border-t-2 items-center flex gap-2 px-3 justify-between transition-all duration-500">
                <div class="flex gap-2 items-center">
                    <div class="bg-cover bg-center aspect-square rounded-md bg-gray-500 w-[45px] h-[45px]">
                    </div>
                    <p class="font-semibold w-full text-elipsis line-clamp-1 transition-all duration-500 text-black">
                        Alexys LAURENT
                    </p>
                </div>
                <div>
                    <div onclick="toggleThemeMode()" class="hover:cursor-pointer">
                        <svg id="moonSvg" class="" xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                            fill="black" class="bi bi-moon-fill" viewBox="0 0 16 16">
                            <path
                                d="M6 .278a.768.768 0 0 1 .08.858 7.208 7.208 0 0 0-.878 3.46c0 4.021 3.278 7.277 7.318 7.277.527 0 1.04-.055 1.533-.16a.787.787 0 0 1 .81.316.733.733 0 0 1-.031.893A8.349 8.349 0 0 1 8.344 16C3.734 16 0 12.286 0 7.71 0 4.266 2.114 1.312 5.124.06A.752.752 0 0 1 6 .278z" />
                        </svg>

                        <svg id="sunSvg" class="hidden" xmlns="http://www.w3.org/2000/svg" width="25" height="25"
                            fill="black" class="bi bi-sun-fill" viewBox="0 0 16 16">
                            <path
                                d="M8 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z" />
                        </svg>
                    </div>
                </div>
            </footer>

        </div>

    </div>

</div>