package com.netscanpro.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.netscanpro.db.DBConnection;
import com.netscanpro.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {

            String hashedPassword =
                    PasswordUtil.hashPassword(password);

            String sql =
                    "INSERT INTO users (username, email, password) " +
                    "VALUES (?, ?, ?)";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, username);
                ps.setString(2, email);
                ps.setString(3, hashedPassword);

                int result = ps.executeUpdate();

                if (result > 0) {

                    response.sendRedirect(
                            "login.jsp?success=registered"
                    );

                } else {

                    response.sendRedirect(
                            "register.jsp?error=failed"
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "register.jsp?error=database"
            );
        }
    }
}