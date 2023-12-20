package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletException;
import java.io.IOException;

@WebServlet("/saveNote")

public class SaveNoteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the theme mode from the request
        HttpSession session = request.getSession();
        String content = request.getParameter("content");
        int idNote = Integer.parseInt(request.getParameter("idNote"));
        User user = (User) session.getAttribute("user");
        int idUser = user.getIdUser();

        Controller.updateNote(idUser,idNote,content);
    }
}