<%@ page session="true" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>NetScanPro - Network Scanner</title>

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

        .brand {
            font-size: 23px;
            font-weight: bold;
            color: #60a5fa;
        }

        .nav-links {
            display: flex;
            gap: 25px;
        }

        .nav-links a {
            color: #cbd5e1;
            text-decoration: none;
            font-size: 14px;
            transition: 0.2s;
        }

        .nav-links a:hover {
            color: #60a5fa;
        }

        .container {
            max-width: 850px;
            margin: 55px auto;
            padding: 20px;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h1 {
            margin: 0 0 10px;
            font-size: 32px;
        }

        .header p {
            margin: 0;
            color: #94a3b8;
        }

        .scanner-card {
            background: #111827;
            border: 1px solid #1f2937;
            border-radius: 14px;
            padding: 35px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.25);
        }

        .section-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 22px;
        }

        label {
            display: block;
            margin-bottom: 9px;
            color: #e2e8f0;
            font-size: 14px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 14px;
            border: 1px solid #374151;
            border-radius: 8px;
            background: #0f172a;
            color: white;
            font-size: 15px;
        }

        input:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.12);
        }

        .port-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }

        .scan-button {
            width: 100%;
            margin-top: 8px;
            padding: 14px;
            border: none;
            border-radius: 8px;
            background: #2563eb;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.2s;
        }

        .scan-button:hover {
            background: #1d4ed8;
        }

        .info-box {
            margin-top: 25px;
            padding: 16px;
            background: #0f172a;
            border: 1px solid #1e3a5f;
            border-left: 4px solid #3b82f6;
            border-radius: 8px;
            color: #cbd5e1;
            line-height: 1.6;
            font-size: 14px;
        }

        .info-title {
            color: #60a5fa;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .bottom-links {
            margin-top: 25px;
            text-align: center;
        }

        .bottom-links a {
            color: #60a5fa;
            text-decoration: none;
            margin: 0 12px;
            font-size: 14px;
        }

        .bottom-links a:hover {
            text-decoration: underline;
        }

        .status {
            margin-top: 18px;
            text-align: center;
            color: #64748b;
            font-size: 13px;
        }

        @media (max-width: 650px) {

            .navbar {
                padding: 16px 20px;
                flex-direction: column;
                gap: 12px;
            }

            .nav-links {
                gap: 15px;
            }

            .container {
                margin: 30px auto;
                padding: 15px;
            }

            .scanner-card {
                padding: 25px 20px;
            }

            .port-row {
                grid-template-columns: 1fr;
                gap: 0;
            }

            .header h1 {
                font-size: 26px;
            }
        }
    </style>
</head>

<body>

    <div class="navbar">

        <div class="brand">
            NetScanPro
        </div>

        <div class="nav-links">
            <a href="dashboard.jsp">Dashboard</a>
            <a href="history.jsp">Scan History</a>
            <a href="logout">Logout</a>
        </div>

    </div>


    <div class="container">

        <div class="header">

            <h1>Network Scanner</h1>

            <p>
                Analyze TCP ports on your authorized local target.
            </p>

        </div>


        <div class="scanner-card">

            <div class="section-title">
                Scan Configuration
            </div>


            <form action="scan" method="post">

                <div class="form-group">

                    <label for="host">
                        Target Host
                    </label>

                    <input
                        type="text"
                        id="host"
                        name="host"
                        placeholder="127.0.0.1"
                        value="127.0.0.1"
                        required
                    >

                </div>


                <div class="port-row">

                    <div class="form-group">

                        <label for="startPort">
                            Start Port
                        </label>

                        <input
                            type="number"
                            id="startPort"
                            name="startPort"
                            min="1"
                            max="65535"
                            value="80"
                            required
                        >

                    </div>


                    <div class="form-group">

                        <label for="endPort">
                            End Port
                        </label>

                        <input
                            type="number"
                            id="endPort"
                            name="endPort"
                            min="1"
                            max="65535"
                            value="80"
                            required
                        >

                    </div>

                </div>


                <button
                    type="submit"
                    class="scan-button"
                >
                    Start Network Scan
                </button>

            </form>


            <div class="info-box">

                <div class="info-title">
                    Authorized Testing Only
                </div>

                NetScanPro is configured for localhost testing.
                Use <strong>127.0.0.1</strong> or
                <strong>localhost</strong> for your local testing environment.

            </div>


            <div class="status">
                TCP Port Scanner • Multithreaded • Timeout Enabled
            </div>


            <div class="bottom-links">

                <a href="dashboard.jsp">
                    Back to Dashboard
                </a>

                <a href="history.jsp">
                    View Scan History
                </a>

            </div>

        </div>

    </div>

</body>
</html>