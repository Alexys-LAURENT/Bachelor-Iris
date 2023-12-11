<html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="Controllera.*" %>
<%@ page import="java.util.ArrayList" %>

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
            ArrayList<Note> notes = Controlleur.getAllNotes();
            for(Note note : notes){
                out.println(note.getTitle());
            }
            // Note uneNote = new Note();
            // uneNote.setTitle("Titre");
            // uneNote.setContent("Contenu");
            // out.println(uneNote.getTitle());
            // out.println(uneNote.getContent());

        %>
        
    </main>
</body>

</html>