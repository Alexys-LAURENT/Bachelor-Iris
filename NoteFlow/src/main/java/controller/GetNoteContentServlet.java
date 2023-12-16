package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import java.io.IOException;

@WebServlet("/getNote")

public class GetNoteContentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the theme mode from the request
        int idNote = Integer.parseInt(request.getParameter("idNote"));

        // Get the note content from the database
        String noteContent = Controller.getNoteContent(idNote);

        // Send the note content to the client
        response.setContentType("text/plain");
        response.getWriter().write(noteContent);

    }
}