<%@ page import="controller.Controller"%>
<%@ page import="controller.ExtendedNote"%>
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
        <%@ include file="views/notesSection.jsp" %>
    </main>
</body>
</html>