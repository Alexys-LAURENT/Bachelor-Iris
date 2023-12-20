<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<%
    if(request.getParameter("idNoteToggleFavoriteIndex") != null){
        int idNoteToggleFavorite = Integer.parseInt(request.getParameter("idNoteToggleFavoriteIndex"));
        Controller.toggleFavorite(idNoteToggleFavorite);
        // refresh
        response.sendRedirect("index.jsp" + (request.getParameter("token") != null ? "?token=" + request.getParameter("token") : ""));
    }

    if(request.getParameter("idNoteDelete") != null){
        int idNoteDelete = Integer.parseInt(request.getParameter("idNoteDelete"));
        Controller.delete(idNoteDelete);
        // refresh
        response.sendRedirect("index.jsp" + (request.getParameter("token") != null ? "?token=" + request.getParameter("token") : ""));
    }
%>

<%
    if(request.getParameter("newTagIndex") != null && request.getParameter("hex") != null){
            Controller.createTagOutsideNote(user.getIdUser(), request.getParameter("newTagIndex"), request.getParameter("hex"));
            // refresh
            response.sendRedirect("index.jsp" + (request.getParameter("token") != null ? "?token=" + request.getParameter("token") : ""));
    }
%>


<%
        if(request.getParameter("idNoteToggleFavorite") != null){
                int idNoteToggleFavorite = Integer.parseInt(request.getParameter("idNoteToggleFavorite"));
                Controller.toggleFavorite(idNoteToggleFavorite);
                // refresh
                response.sendRedirect("index.jsp" + (request.getParameter("token") != null ? "?token=" + request.getParameter("token") : "") + (request.getParameter("note") != null ? "&note=" + request.getParameter("note") : ""));
        }

        if(request.getParameter("idTag") != null){
                Controller.updateNoteTag(Integer.parseInt(request.getParameter("note")), Integer.parseInt(request.getParameter("idTag")));
                // refresh
                response.sendRedirect("index.jsp" + (request.getParameter("token") != null ? "?token=" + request.getParameter("token") : "") + (request.getParameter("note") != null ? "&note=" + request.getParameter("note") : ""));
        }

        if(request.getParameter("newTag") != null && request.getParameter("hex") != null){
                Controller.createTagInNote(user.getIdUser(), request.getParameter("newTag"), request.getParameter("hex"), Integer.parseInt(request.getParameter("note")));
                // refresh
                response.sendRedirect("index.jsp" + (request.getParameter("token") != null ? "?token=" + request.getParameter("token") : "") + (request.getParameter("note") != null ? "&note=" + request.getParameter("note") : ""));
        }
%>

<% if (request.getParameter("newNoteIndex") != null) {
    Controller.createNote(
        request.getParameter("newNoteIndex"),
        request.getParameter("idCategorie"),
        user.getIdUser()
    );
    response.sendRedirect("index.jsp" + (request.getParameter("token") != null ? "?token=" + request.getParameter("token") : ""));
} %>


<% 
    if (request.getParameter("editTagSelect") != null && request.getParameter("NewTagName") != null && request.getParameter("NewTagHex") != null) {
        Controller.editTag(Integer.parseInt(request.getParameter("editTagSelect")), request.getParameter("NewTagName"), request.getParameter("NewTagHex"));
        // refresh page
        response.sendRedirect("index.jsp" + (request.getParameter("token") != null ? "?token=" + request.getParameter("token") : ""));
    }
%>


<% if (request.getParameter("selectUserPartage") != null && request.getParameter("selectUserPartage") != "" && request.getParameter("selectDroitPartage") != null && request.getParameter("selectDroitPartage") != "") {
        Controller.shareNoteWithUser(Integer.parseInt(request.getParameter("note")), user.getIdUser(), Integer.parseInt(request.getParameter("selectUserPartage")), request.getParameter("selectDroitPartage"));
        // refresh
        response.sendRedirect("index.jsp" + (request.getParameter("token") != null ? "?token=" + request.getParameter("token") : "") + (request.getParameter("note") != null ? "&note=" + request.getParameter("note") : ""));
} %>

<% if (request.getParameter("idShare") != null) {
        Controller.deleteShare(Integer.parseInt(request.getParameter("idShare")), user.getIdUser());
        // refresh page
        response.sendRedirect("index.jsp" + (request.getParameter("token") != null ? "?token=" + request.getParameter("token") : "") + (request.getParameter("note") != null ? "&note=" + request.getParameter("note") : ""));
} %>

<!DOCTYPE html>
<html lang="en" class="<%= user != null ? user.getTheme() : "white" %>">
<head>
    <title>NoteFlow</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/index.css?v=7">
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
<body class="bg-bgLight dark:bgDark">
    <main class="flex flex-col md:flex-row w-full h-screen bg-bgLight dark:bg-dark md:overflow-hidden transition-all duration-500">
    <%
        if (user != null) {
    %>
        <%@ include file="views/sideBar.jsp" %>

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

    <%
        }
    %>
      

    </main>
</body>
</html>