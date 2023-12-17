<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="controller.Controller"%>
<%@ page import="controller.ExtendedNote"%>
<%@ page import="controller.User"%>
<%@ page import="java.util.ArrayList"%>

<%-- Check token in URL, if it is valid, set the session attribute to the token --%>
<%
    String token = request.getParameter("token");
    User user = Controller.checkToken(token);
    if (user == null) {
        response.sendRedirect("login.jsp");
    } else {
        session.setAttribute("token", token);
        session.setAttribute("user", user);
    }
%>

<!DOCTYPE html>
<html lang="en" class="<%= user != null ? user.getTheme() : "white" %>">
<head>
    <title>NoteFlow</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/index.css?v=4">
    <script defer src="js/index.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/editorjs@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/table@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/marker@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/header@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/list@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/nested-list@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/code@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/embed@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/paragraph@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/quote@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/delimiter@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/warning@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/checklist@latest"></script>
    <script src="
        https://cdn.jsdelivr.net/npm/sweetalert2@11.10.0/dist/sweetalert2.all.min.js
    "></script>
    <script>
        tailwind.config = {
            important: true,
            theme: {
                extend: {
                    colors: {
                        bgLight: '#f9fbfc',
                        darkNote: "#171D27",
                        dark: "#0d1117",
                        }
                    }
                },
                darkMode: "class",
            }
    </script>
</head>
<body>
    <main class="flex flex-col md:flex-row w-full h-screen bg-bgLight overflow-hidden">
    <%
        if (user != null) {
    %>
        <%@ include file="views/sideBar.jsp" %>

    <%
        }
    %>

    <%
	    if (request.getParameter("note") != null) {
	%>
	        <%@  include file="views/notePage.jsp" %>
	<%
	    } else {
	%>
	        <%@  include file="views/notesSection.jsp" %>
	<%
	    }
	%>
      

    </main>
</body>
</html>