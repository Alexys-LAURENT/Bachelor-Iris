package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/getColleguesAndShares")

public class GetColleguesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the theme mode from the request
        int idUser = Integer.parseInt(request.getParameter("idUser"));
        int idNote = Integer.parseInt(request.getParameter("idNote"));

        // Get the collegues from the database
        ArrayList<User> collegues = Controller.getCollegues(idUser);

        // Get the list of shares from the database
        ArrayList<Share> shares = Controller.getShares(idNote);

        // Send the collegues and shares to the client in JSON format
        response.setContentType("application/json");
        response.getWriter().write("{\"collegues\":[");
        for (int i = 0; i < collegues.size(); i++) {
            response.getWriter().write("{\"id\":" + collegues.get(i).getIdUser() + ",\"prenom\":\""
                    + collegues.get(i).getPrenom() + "\",\"nom\":\"" + collegues.get(i).getNom() + "\",\"pp\":\""
                    + collegues.get(i).getPp() + "\"}");
            if (i != collegues.size() - 1) {
                response.getWriter().write(",");
            }
        }
        response.getWriter().write("],\"shares\":[");
        for (int i = 0; i < shares.size(); i++) {
            response.getWriter().write("{\"id\":" + shares.get(i).getIdShare() + ",\"idOwner\":\""
                    + shares.get(i).getIdOwner() + "\",\"idShared\":\"" + shares.get(i).getIdShared()
                    + "\",\"prenom\":\"" + shares.get(i).getPrenom() + "\",\"nom\":\"" + shares.get(i).getNom()
                    + "\",\"pp\":\"" + shares.get(i).getPp() + "\",\"permissions\":\"" + shares.get(i).getPermissions()
                    + "\"}");
            if (i != shares.size() - 1) {
                response.getWriter().write(",");
            }
        }
        response.getWriter().write("]}");
    }
}