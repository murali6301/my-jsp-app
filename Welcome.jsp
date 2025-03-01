<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: url('background.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #333;
        }
        .navbar, .footer {
            background: rgba(255, 255, 255, 0.7);
            padding: 1em;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .navbar a {
            margin: 0 1em;
            color: #333;
            text-decoration: none;
            font-size: 1.2em;
            font-weight: bold;
        }
        .navbar a:hover {
            color: #007BFF;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 80vh;
        }
        .form-container {
            background: rgba(255, 255, 255, 0.8);
            padding: 2em;
            border-radius: 10px;
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .form-container h2 {
            margin-bottom: 1em;
            color: #007BFF;
        }
        .footer p {
            margin: 0;
        }
        .footer a {
            color: #007BFF;
            text-decoration: none;
        }
        .footer a:hover {
            text-decoration: underline;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        ul li {
            margin: 0.5em 0;
        }
        ul li a {
            color: #007BFF;
            text-decoration: none;
            font-weight: bold;
        }
        ul li a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>Privacy Preservation In Multi Cloud Fusion</h1> <br>
        <nav>
            <a href="index.jsp">Home</a>
            <form action="logout.jsp" method="post" style="display: inline;">
                <button type="submit">Logout</button>
            </form>
        </nav>
    </div>
    <div class="container">
        <div class="form-container">
            <h2>Welcome</h2>
<%
String username = (String) session.getAttribute("username");
String fullname = (String) session.getAttribute("fullname");
String email = (String) session.getAttribute("email");
String gender = (String) session.getAttribute("gender");
String phone = (String) session.getAttribute("phone");
String address = (String) session.getAttribute("address");

if (username != null) {
%>
            <p>Welcome, <%= username %>!</p>
            <p>We are committed to protecting your privacy and ensuring that your personal information is secure. Our privacy-preserving data fusion techniques ensure that your data remains confidential and protected at all times.</p>
            <p>Access your cloud information securely without privacy leakage:</p>
            <ul>
                <li><a href="https://aws.amazon.com/">Amazon Web Services</a></li>
                <li><a href="https://azure.microsoft.com/">Microsoft Azure</a></li>
                <li><a href="https://cloud.google.com/">Google Cloud</a></li>
                <li><a href="https://www.ibm.com/cloud">IBM Cloud</a></li>
            </ul>
<%
} else {
%>
            <p>User information not found. Please log in.</p>
<%
}
%>
        </div>
    </div>
    <div class="footer">
        <p>&copy; 2025 Privacy Preservation In Multi Cloud Fusion</p>
    </div>
</body>
</html>
