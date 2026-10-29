<%@ page import="java.sql.*" %>
<%@ page import="com.netscanpro.db.DBConnection" %>
<%@ page session="true" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (Integer) session.getAttribute("userId");
    String username = (String) session.getAttribute("username");

    int totalScans = 0;
    int openPorts = 0;

    try (Connection con = DBConnection.getConnection()) {

        String sql1 =
            "SELECT COUNT(*) FROM scan_history WHERE user_id = ?";

        try (PreparedStatement ps = con.prepareStatement(sql1)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    totalScans = rs.getInt(1);
                }
            }
        }

        String sql2 =
            "SELECT COUNT(*) " +
            "FROM scan_results sr " +
            "JOIN scan_history sh ON sr.scan_id = sh.id " +
            "WHERE sh.user_id = ? AND sr.status = 'OPEN'";

        try (PreparedStatement ps = con.prepareStatement(sql2)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    openPorts = rs.getInt(1);
                }
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>NetScanPro - Security Dashboard</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #0b1120;
            color: #f8fafc;
        }

        .navbar {
            background: #111827;
            border-bottom: 1px solid #1f2937;
            padding: 18px 35px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 23px;
            font-weight: bold;
            color: #60a5fa;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 22px;
        }

        .user {
            color: #cbd5e1;
            font-size: 14px;
        }

        .logout {
            color: #60a5fa;
            text-decoration: none;
            font-size: 14px;
        }

        .logout:hover {
            text-decoration: underline;
        }

        .container {
            max-width: 1100px;
            margin: 50px auto;
            padding: 20px;
        }

        .welcome {
            margin-bottom: 35px;
        }

        .welcome h1 {
            margin: 0 0 10px;
            font-size: 32px;
        }

        .welcome p {
            margin: 0;
            color: #94a3b8;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 35px;
        }

        .card {
            background: #111827;
            border: 1px solid #1f2937;
            border-radius: 14px;
            padding: 25px;

            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.20);

            transition: transform 0.2s, border-color 0.2s;
        }

        .card:hover {
            transform: translateY(-3px);
            border-color: #334155;
        }

        .card-title {
            color: #94a3b8;
            font-size: 14px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .number {
            font-size: 36px;
            font-weight: bold;
            margin-top: 15px;
            color: #f8fafc;
        }

        .description {
            margin-top: 8px;
            color: #64748b;
            font-size: 13px;
        }

        .actions-section {
            background: #111827;
            border: 1px solid #1f2937;
            border-radius: 14px;
            padding: 25px;
        }

        .actions-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 18px;
        }

        .actions {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-block;
            padding: 13px 22px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            background: #2563eb;
            color: white;

            transition: background 0.2s;
        }

        .btn:hover {
            background: #1d4ed8;
        }

        .secondary {
            background: #1f2937;
        }

        .secondary:hover {
            background: #374151;
        }

        .security-note {
            margin-top: 25px;
            padding: 16px;

            background: #0f172a;
            border: 1px solid #1e3a5f;
            border-left: 4px solid #3b82f6;

            border-radius: 8px;
            color: #cbd5e1;
            font-size: 14px;
            line-height: 1.6;
        }

        .security-note strong {
            color: #60a5fa;
        }

        .footer {
            text-align: center;
            margin-top: 35px;
            color: #475569;
            font-size: 13px;
        }

        @media (max-width: 750px) {

            .navbar {
                padding: 16px 20px;
                flex-direction: column;
                gap: 12px;
            }

            .container {
                margin: 30px auto;
                padding: 15px;
            }

            .cards {
                grid-template-columns: 1fr;
            }

            .welcome h1 {
                font-size: 26px;
            }

            .actions {
                flex-direction: column;
            }

            .btn {
                text-align: center;
            }
        }

    </style>

</head>

<body>

    <div class="navbar">

        <div class="logo">
            NetScanPro
        </div>

        <div class="nav-right">

            <div class="user">
                Welcome, <strong><%= username %></strong>
            </div>

            <a class="logout" href="logout">
                Logout
            </a>

        </div>

    </div>


    <div class="container">

        <div class="welcome">

            <h1>
                Security Dashboard
            </h1>

            <p>
                Monitor and review your authorized network scanning activity.
            </p>

        </div>


        <div class="cards">

            <div class="card">

                <div class="card-title">
                    Total Scans
                </div>

                <div class="number">
                    <%= totalScans %>
                </div>

                <div class="description">
                    Scans performed by your account
                </div>

            </div>


            <div class="card">

                <div class="card-title">
                    Open Ports
                </div>

                <div class="number">
                    <%= openPorts %>
                </div>

                <div class="description">
                    Open TCP ports detected
                </div>

            </div>


            <div class="card">

                <div class="card-title">
                    Platform
                </div>

                <div class="number">
                    NSP
                </div>

                <div class="description">
                    NetScanPro Security Scanner
                </div>

            </div>

        </div>


        <div class="actions-section">

            <div class="actions-title">
                Quick Actions
            </div>

            <div class="actions">

                <a class="btn" href="scan.jsp">
                    Start Network Scan
                </a>

                <a class="btn secondary" href="history.jsp">
                    View Scan History
                </a>

            </div>


            <div class="security-note">

                <strong>Security Notice:</strong>
                NetScanPro is configured for authorized localhost testing.
                Use the scanner only in environments where you have permission
                to perform security testing.

            </div>

        </div>


        <div class="footer">
            NetScanPro • Network Security Monitoring
        </div>

    </div>

</body>

</html>