<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
             background: url('background.jpg') no-repeat center center fixed; 
            background-size: cover;
        }
        .navbar, .footer {
            background: rgba(255, 255, 255, 0.3);
            padding: 1em;
            text-align: center;
            backdrop-filter: blur(10px);
        }
        .navbar a {
            margin: 0 1em;
            color: black;
            text-decoration: none;
            font-size: 1.2em;
            font-weight: bold;
        }
       .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 2em;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 10px;
            backdrop-filter: blur(10px);
            margin: 2em auto;
            max-width: 800px;
        }

        .container h3 {
            font-size: 1.8em;
            margin-bottom: 1em;
            color: black;
        }

        .container p {
            font-size: 1.2em;
            line-height: 1.6em;
            color: black;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>Privacy Preservation In Multi Cloud Fusion</h1> <br>
        <nav>
            <a href="login.jsp">Login</a>
            <a href="Rigister.jsp">Register</a>
            <a href="admin.jsp">Admin</a>
        </nav>
    </div>
    <div class="container">
 <h3>Your Privacy Matters</h3>
        <p>We are committed to protecting your privacy and ensuring that your personal information is secure. Our privacy-preserving data fusion techniques ensure that your data remains confidential and protected at all times.</p>
        <p>Learn more about how we safeguard your data:</p>
        <ul>
            <li>Data Encryption: Advanced encryption methods to protect your information.</li>
            <li>Access Control: Strict user authentication and authorization protocols.</li>
            <li>Privacy Preservation: Cutting-edge techniques to ensure data anonymity and security.</li>
        </ul>
    </div>
    <div class="footer">
        <p>&copy; 2025 Privacy Preservation In Multi Cloud Fusion</p>
    </div>
</body>
</html>
