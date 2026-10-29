<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>NetScanPro - Login</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #0b1120;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 380px;
            background: #111827;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
        }

        h1 {
            text-align: center;
            margin-bottom: 10px;
        }

        .subtitle {
            text-align: center;
            color: #9ca3af;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 7px;
        }

        input {
            width: 100%;
            box-sizing: border-box;
            padding: 12px;
            margin-bottom: 18px;
            border: 1px solid #374151;
            border-radius: 6px;
            background: #1f2937;
            color: white;
        }

        button {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 6px;
            background: #2563eb;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: #1d4ed8;
        }

        .register {
            text-align: center;
            margin-top: 20px;
            color: #9ca3af;
        }

        a {
            color: #60a5fa;
            text-decoration: none;
        }

        .message {
            text-align: center;
            color: #f87171;
            margin-bottom: 15px;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>NetScanPro</h1>

    <div class="subtitle">
        Secure Network Security Platform
    </div>

    <% 
        String error = request.getParameter("error");
        if ("invalid".equals(error)) {
    %>
        <div class="message">Invalid email or password.</div>
    <% 
        } else if ("database".equals(error)) {
    %>
        <div class="message">Database connection error.</div>
    <% 
        }
    %>

    <form action="login" method="post">

        <label>Email</label>
        <input type="email" name="email" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <button type="submit">Login</button>

    </form>

    <div class="register">
        Don't have an account?
        <a href="register.jsp">Create Account</a>
    </div>

</div>

</body>
</html>