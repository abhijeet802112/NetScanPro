<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>NetScan Pro</title>

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
            margin: 50px auto;
            padding: 20px;
        }

        .hero {
            margin-bottom: 30px;
        }

        .hero h1 {
            font-size: 32px;
            margin-bottom: 10px;
        }

        .hero p {
            color: #6b7280;
            font-size: 16px;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        .form-row {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr;
            gap: 20px;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #d1d5db;
            border-radius: 7px;
            font-size: 15px;
        }

        button {
            padding: 12px 25px;
            border: none;
            border-radius: 7px;
            background: #2563eb;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: #1d4ed8;
        }

        button:disabled {
            background: #9ca3af;
            cursor: not-allowed;
        }

        .info {
            margin-top: 25px;
            padding: 15px;
            background: #eff6ff;
            border-left: 4px solid #2563eb;
            border-radius: 5px;
        }

        .scan-status {
            display: none;
            margin-top: 20px;
            padding: 12px;
            background: #f3f4f6;
            border-radius: 7px;
            text-align: center;
            font-weight: bold;
        }

        .spinner {
            display: inline-block;
            width: 16px;
            height: 16px;
            border: 3px solid #d1d5db;
            border-top: 3px solid #2563eb;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-right: 8px;
            vertical-align: middle;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        @media (max-width: 700px) {
            .form-row {
                grid-template-columns: 1fr;
            }

            .container {
                margin: 25px auto;
            }
        }
    </style>
</head>

<body>

<div class="navbar">
    NetScan Pro
</div>

<div class="container">

    <div class="hero">
        <h1>Network Security Scanner</h1>
        <p>
            Multithreaded TCP port scanning and security assessment platform.
        </p>
    </div>

    <div class="card">

        <form action="scan" method="post" id="scanForm">

            <div class="form-row">

                <div>
                    <label for="host">Target Host</label>
                    <input
                        type="text"
                        id="host"
                        name="host"
                        placeholder="localhost"
                        required>
                </div>

                <div>
                    <label for="startPort">Start Port</label>
                    <input
                        type="number"
                        id="startPort"
                        name="startPort"
                        min="1"
                        max="65535"
                        value="1"
                        required>
                </div>

                <div>
                    <label for="endPort">End Port</label>
                    <input
                        type="number"
                        id="endPort"
                        name="endPort"
                        min="1"
                        max="65535"
                        value="100"
                        required>
                </div>

            </div>

            <button type="submit" id="scanButton">
                Start Scan
            </button>

        </form>

        <div class="scan-status" id="scanStatus">
            <span class="spinner"></span>
            Scan in progress... Please wait.
        </div>

        <div class="info">
            <strong>Authorized Testing Only:</strong>
            Use NetScan Pro only on systems you own or have explicit permission to test.
        </div>

    </div>

</div>

<script>
    document.getElementById("scanForm").addEventListener("submit", function () {

        document.getElementById("scanStatus").style.display = "block";

        document.getElementById("scanButton").disabled = true;
        document.getElementById("scanButton").textContent = "Scanning...";

    });
</script>

</body>
</html>