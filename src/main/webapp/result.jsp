<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<%
    String host = (String) request.getAttribute("host");
    Integer startPort = (Integer) request.getAttribute("startPort");
    Integer endPort = (Integer) request.getAttribute("endPort");

    List<Integer> openPorts =
            (List<Integer>) request.getAttribute("openPorts");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Scan Results - NetScan Pro</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f7fb;
            color: #1f2937;
        }

        .navbar {
            background: #111827;
            color: white;
            padding: 18px 40px;
            font-size: 22px;
            font-weight: bold;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
        }

        .header {
            margin-bottom: 25px;
        }

        .header h1 {
            margin-bottom: 8px;
        }

        .header p {
            color: #6b7280;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        .summary {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
        }

        .stat {
            padding: 20px;
            background: #f9fafb;
            border-radius: 8px;
        }

        .stat span {
            display: block;
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .stat strong {
            font-size: 22px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th, td {
            padding: 13px;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }

        th {
            background: #f9fafb;
        }

        .open {
            font-weight: bold;
        }

        .empty {
            padding: 20px;
            background: #f9fafb;
            border-radius: 8px;
            color: #6b7280;
        }

        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 20px;
            background: #2563eb;
            color: white;
            text-decoration: none;
            border-radius: 7px;
        }

        .back-btn:hover {
            background: #1d4ed8;
        }

        @media (max-width: 700px) {
            .summary {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<div class="navbar">
    NetScan Pro
</div>

<div class="container">

    <div class="header">
        <h1>Scan Results</h1>
        <p>TCP port scan completed successfully.</p>
    </div>

    <div class="card">

        <div class="summary">

            <div class="stat">
                <span>Target</span>
                <strong><%= host %></strong>
            </div>

            <div class="stat">
                <span>Port Range</span>
                <strong><%= startPort %> - <%= endPort %></strong>
            </div>

            <div class="stat">
                <span>Open Ports</span>
                <strong><%= openPorts != null ? openPorts.size() : 0 %></strong>
            </div>

        </div>

    </div>

    <div class="card">

        <h2>Open Ports</h2>

        <%
            if (openPorts != null && !openPorts.isEmpty()) {
        %>

        <table>
            <thead>
            <tr>
                <th>#</th>
                <th>Port</th>
                <th>Status</th>
            </tr>
            </thead>

            <tbody>

            <%
                int count = 1;

                for (Integer port : openPorts) {
            %>

            <tr>
                <td><%= count++ %></td>
                <td><%= port %></td>
                <td class="open">OPEN</td>
            </tr>

            <%
                }
            %>

            </tbody>
        </table>

        <%
            } else {
        %>

        <div class="empty">
            No open ports were detected in the selected range.
        </div>

        <%
            }
        %>

        <a href="index.jsp" class="back-btn">
            New Scan
        </a>

    </div>

</div>

</body>
</html>