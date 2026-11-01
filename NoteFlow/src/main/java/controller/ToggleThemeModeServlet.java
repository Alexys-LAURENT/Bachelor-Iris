package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import java.io.IOException;

@WebServlet("/toggleThemeMode")

public class ToggleThemeModeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the theme mode from the request
        String themeMode = request.getParameter("theme");
        int idUser = Integer.parseInt(request.getParameter("idUser"));

        // Toggle the theme mode
        if ("dark".equals(themeMode)) {
            // Switch to light mode
            Controller.toggleThemeMode("white", idUser);
        } else if ("white".equals(themeMode)) {
            // Switch to dark mode
            Controller.toggleThemeMode("dark", idUser);
        }
    }
}