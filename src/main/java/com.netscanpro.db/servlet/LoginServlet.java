package com.netscanpro.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.netscanpro.db.DBConnection;
import com.netscanpro.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String sql =
                "SELECT id, username, password FROM users WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()
                        && PasswordUtil.verifyPassword(
                                password,
                                rs.getString("password"))) {

                    HttpSession session = request.getSession();

                    session.setAttribute(
                            "userId",
                            rs.getInt("id")
                    );

                    session.setAttribute(
                            "username",
                            rs.getString("username")
                    );

                    response.sendRedirect("dashboard.jsp");

                } else {

                    response.sendRedirect(
                            "login.jsp?error=invalid"
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "login.jsp?error=database"
            );
        }
    }
}