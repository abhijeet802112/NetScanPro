package com.netscanpro.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import com.netscanpro.db.DBConnection;
import com.netscanpro.scanner.TcpPortScanner;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/scan")
public class ScanServlet extends HttpServlet {

    private static final int TIMEOUT = 300;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Check login/session
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String host = request.getParameter("host");
        String startPortValue = request.getParameter("startPort");
        String endPortValue = request.getParameter("endPort");

        // Basic input validation
        if (host == null || host.isBlank()
                || startPortValue == null
                || endPortValue == null) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid scan request."
            );
            return;
        }

        String target = host.trim();

        // Safe-target restriction
        if (!target.equals("127.0.0.1")
                && !target.equals("localhost")) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only localhost scanning is allowed."
            );
            return;
        }

        try {

            int userId = (Integer) session.getAttribute("userId");

            int startPort = Integer.parseInt(startPortValue);
            int endPort = Integer.parseInt(endPortValue);

            // Port range validation
            if (startPort < 1
                    || endPort > 65535
                    || startPort > endPort
                    || (endPort - startPort) > 1000) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid port range."
                );
                return;
            }

            // Start scanner
            TcpPortScanner scanner = new TcpPortScanner(20);

            List<Integer> openPorts =
                    scanner.scan(
                            target,
                            startPort,
                            endPort,
                            TIMEOUT
                    );

            scanner.shutdown();

            // Save scan history
            int scanId = 0;

            String historySql =
                    "INSERT INTO scan_history " +
                    "(user_id, target, start_port, end_port) " +
                    "VALUES (?, ?, ?, ?)";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps =
                         con.prepareStatement(
                                 historySql,
                                 PreparedStatement.RETURN_GENERATED_KEYS)) {

                ps.setInt(1, userId);
                ps.setString(2, target);
                ps.setInt(3, startPort);
                ps.setInt(4, endPort);

                ps.executeUpdate();

                try (ResultSet keys = ps.getGeneratedKeys()) {

                    if (keys.next()) {
                        scanId = keys.getInt(1);
                    }
                }
            }

            // Save open ports
            if (scanId > 0 && openPorts != null
                    && !openPorts.isEmpty()) {

                String resultSql =
                        "INSERT INTO scan_results " +
                        "(scan_id, port, status) " +
                        "VALUES (?, ?, ?)";

                try (Connection con = DBConnection.getConnection();
                     PreparedStatement ps =
                             con.prepareStatement(resultSql)) {

                    for (Integer port : openPorts) {

                        ps.setInt(1, scanId);
                        ps.setInt(2, port);
                        ps.setString(3, "OPEN");

                        ps.addBatch();
                    }

                    ps.executeBatch();
                }
            }

            // Send results to result.jsp
            request.setAttribute("host", target);
            request.setAttribute("startPort", startPort);
            request.setAttribute("endPort", endPort);
            request.setAttribute("openPorts", openPorts);

            request.getRequestDispatcher("result.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Port numbers must be valid integers."
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to complete the scan."
            );
        }
    }
}