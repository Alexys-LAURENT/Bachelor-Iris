<%@ page import="controller.Controller"%>
<%@ page import="controller.Note"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>NoteFlow</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/index.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <script defer src="js/index.js"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        bgLight: '#f9fbfc',
                        }
                    }
                }
            }
    </script>
</head>
<body>
    <main class="flex flex-col md:flex-row w-screen min-h-screen bg-bgLight">
        <%@ include file="views/sideBar.jsp" %>
        <h2 class="text-clifford">Hello World!</h2>
        <%
            ArrayList<Note> notes = Controller.getAllNotes();
            for(Note note : notes){
                out.println(note.getTitle());
            }

        %>
        
    </main>
</body>
</html>