package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import java.io.IOException;

@WebServlet("/renameNote")

public class RenameNoteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the theme mode from the request
        String titre = request.getParameter("titre");
        int idNote = Integer.parseInt(request.getParameter("idNote"));

        Controller.renameNote(titre, idNote);
    }
}