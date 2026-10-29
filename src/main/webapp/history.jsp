<%@ page import="java.sql.*" %>
<%@ page import="com.netscanpro.db.DBConnection" %>
<%@ page session="true" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (Integer) session.getAttribute("userId");

    String sql =
        "SELECT sh.id, sh.target, sh.start_port, sh.end_port, sh.scan_time, " +
        "COUNT(CASE WHEN sr.status = 'OPEN' THEN 1 END) AS open_ports " +
        "FROM scan_history sh " +
        "LEFT JOIN scan_results sr ON sh.id = sr.scan_id " +
        "WHERE sh.user_id = ? " +
        "GROUP BY sh.id, sh.target, sh.start_port, sh.end_port, sh.scan_time " +
        "ORDER BY sh.scan_time DESC";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>NetScanPro - Scan History</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #0b1120;
            color: white;
        }

        .navbar {
            background: #111827;
            padding: 18px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar strong {
            font-size: 22px;
        }

        .navbar a {
            color: #60a5fa;
            text-decoration: none;
            margin-left: 20px;
        }

        .container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 20px;
        }

        h1 {
            margin-bottom: 8px;
        }

        .subtitle {
            color: #9ca3af;
            margin-bottom: 30px;
        }

        .card {
            background: #111827;
            border: 1px solid #1f2937;
            border-radius: 12px;
            padding: 20px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #374151;
        }

        th {
            color: #93c5fd;
        }

        td {
            color: #d1d5db;
        }

        .open {
            color: #fbbf24;
            font-weight: bold;
        }

        .empty {
            text-align: center;
            padding: 40px;
            color: #9ca3af;
        }

        .scan-btn {
            display: inline-block;
            margin-top: 25px;
            padding: 12px 20px;
            background: #2563eb;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .scan-btn:hover {
            background: #1d4ed8;
        }
    </style>
</head>

<body>

<div class="navbar">

    <strong>NetScanPro</strong>

    <div>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="scan.jsp">New Scan</a>
        <a href="logout">Logout</a>
    </div>

</div>

<div class="container">

    <h1>Scan History</h1>

    <div class="subtitle">
        View your previous network scanning activity.
    </div>

    <div class="card">

        <table>

            <thead>
                <tr>
                    <th>ID</th>
                    <th>Target</th>
                    <th>Port Range</th>
                    <th>Open Ports</th>
                    <th>Scan Time</th>
                </tr>
            </thead>

            <tbody>

            <%
                boolean hasHistory = false;

                try (Connection con = DBConnection.getConnection();
                     PreparedStatement ps = con.prepareStatement(sql)) {

                    ps.setInt(1, userId);

                    try (ResultSet rs = ps.executeQuery()) {

                        while (rs.next()) {

                            hasHistory = true;
            %>

                <tr>
                    <td><%= rs.getInt("id") %></td>

                    <td>
                        <%= rs.getString("target") %>
                    </td>

                    <td>
                        <%= rs.getInt("start_port") %>
                        -
                        <%= rs.getInt("end_port") %>
                    </td>

                    <td class="open">
                        <%= rs.getInt("open_ports") %>
                    </td>

                    <td>
                        <%= rs.getTimestamp("scan_time") %>
                    </td>
                </tr>

            <%
                        }
                    }

                } catch (Exception e) {

                    e.printStackTrace();
            %>

                <tr>
                    <td colspan="5" class="empty">
                        Unable to load scan history.
                    </td>
                </tr>

            <%
                }

                if (!hasHistory) {
            %>

                <tr>
                    <td colspan="5" class="empty">
                        No scan history found.
                    </td>
                </tr>

            <%
                }
            %>

            </tbody>

        </table>

        <a href="scan.jsp" class="scan-btn">
            Start New Scan
        </a>

    </div>

</div>

</body>
</html>