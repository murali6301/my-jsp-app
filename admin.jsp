<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Page</title>
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
            z-index: -1;
            text-align: center;
            backdrop-filter: blur(10px);
        }
        .footer {
            text-align: center;
            position: absolute;
            bottom: 0;
            width: 100%;
        }
        .navbar a {
            margin: 0 1em;
            color: black;
            text-decoration: none;
            font-size: 1.2em;
            font-weight: bold;
        }
        .container {
            width: 300px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }
        form {
            display: flex;
            flex-direction: column;
        }
        .label2 {
            font-weight: bold;
            color: #333;
        }
        input[type="text"], input[type="password"] {
            width: 92%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 5px;
            font-size: 14px;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
            background-color: rgba(255, 255, 255, 0.8);
        }
        input[type="submit"] {
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .table-container {
            margin: 2em 0;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 10px;
            padding: 1em;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.1);
            margin-top: 2em;
        }
        th, td {
            padding: 0.5em;
            text-align: left;
            border-bottom: 1px solid #ddd;
            font-size: 1em;
        }
        th {
            font-size: 1.2em;
            font-weight: bold;
            text-transform: uppercase;
        }
        td {
            font-size: 1em;
        }
        .logout-button {
            background-color: white;
            color: black;
            padding: 0.5em 1em;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 1em;
            margin: 0.5em 0;
            cursor: pointer;
            border: none;
            border-radius: 5px;
        }
        .logout-button:hover {
            background-color: red;
            color: black;
        }
    </style>
    <script>
        function hideForm() {
            document.getElementById('loginForm').style.display = 'none';
            document.getElementById('loginForm2').style.display = 'none';
        }
        function showLoginForm() {
            document.getElementById('loginForm').style.display = 'block';
            document.getElementById('loginForm2').style.display = 'block';
            document.getElementById('table-container').style.display = 'none';
        }
    </script>
</head>
<body>
    <div class="navbar">
        <h1>Privacy Preservation In Multi Cloud Fusion</h1>
        <h3>Admin Login</h3>
        <nav>
            <a href="index.jsp">Home</a>
        </nav>
    </div>
    <br>
    <div class="container" id="loginForm2">
        <form method="post" id="loginForm">
            <label class="label2" for="adminUsername">Username:</label> 
            <input type="text" id="adminUsername" name="adminUsername" required><br><br>
            <label class="label2" for="adminPassword">Password:</label>
            <input type="password" id="adminPassword" name="adminPassword" required><br><br>
            <input type="submit" value="Login">
        </form>
    </div>
    <div class="table-container" id="table-container" style="display:none;">
        <%
            if (request.getMethod().equalsIgnoreCase("post")) {
                String adminUsername = request.getParameter("adminUsername");
                String adminPassword = request.getParameter("adminPassword");

                String url = "jdbc:mysql://root:mKHuZIscurswmblwMWeLePtZsxZiAPEN@mysql.railway.internal:3306/railway";
                String dbUser = "root";
                String dbPassword = "mKHuZIscurswmblwMWeLePtZsxZiAPEN";
                Connection conn = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(url, dbUser, dbPassword);

                    String adminQuery = "SELECT * FROM admin WHERE username=? AND password=?";
                    PreparedStatement adminStmt = conn.prepareStatement(adminQuery);
                    adminStmt.setString(1, adminUsername);
                    adminStmt.setString(2, adminPassword);
                    ResultSet adminRs = adminStmt.executeQuery();

                    if (adminRs.next()) {
                        session.setAttribute("loggedIn", true);
                        session.setAttribute("adminUsername", adminUsername);
                        %>
                        <script>
                            hideForm();
                            document.getElementById('table-container').style.display = 'block';
                        </script>
                        <%
                        out.println("<h2>Welcome, " + adminUsername + "!</h2>");
                        out.println("<form method='post' action=''>");
                        out.println("<button type='submit' name='logout' class='logout-button'>Logout</button>");
                        out.println("</form>");
                        
                        String userQuery = "SELECT username, fullname, email, gender, phone, address, status FROM clients";
                        Statement userStmt = conn.createStatement();
                        ResultSet userRs = userStmt.executeQuery(userQuery);
                        out.println("<table>");
                        out.println("<tr><th>Username</th><th>Fullname</th><th>Email</th><th>Gender</th><th>Phone</th><th>Address</th><th>Status</th><th>Actions</th></tr>");
                        while (userRs.next()) {
                            String username = userRs.getString("username");
                            String status = userRs.getString("status");
                            out.println("<tr>");
                            out.println("<td>" + userRs.getString("username") + "</td>");
                            out.println("<td>" + userRs.getString("fullname") + "</td>");
                            out.println("<td>" + userRs.getString("email") + "</td>");
                            out.println("<td>" + userRs.getString("gender") + "</td>");
                            out.println("<td>" + userRs.getString("phone") + "</td>");
                            out.println("<td>" + userRs.getString("address") + "</td>");
                            out.println("<td>" + status + "</td>");
                            out.println("<td>");
                            if ("pending".equals(status)) {
                                out.println("<form method='post' action='' style='display:inline;'>");
                                out.println("<input type='hidden' name='approveUsername' value='" + username + "'>");
                                out.println("<button type='submit'>Approve</button>");
                                out.println("</form>");
                                
                                out.println("<form method='post' action='' style='display:inline;'>");
                                out.println("<input type='hidden' name='rejectUsername' value='" + username + "'>");
                                out.println("<button type='submit'>Reject</button>");
                                out.println("</form>");
                            } else {
                                out.println("-");
                            }
                            out.println("</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
                    } else {
                        out.println("<h2>Invalid admin credentials</h2>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (conn != null)
                            try {
                                conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                

                if (request.getParameter("approveUsername") != null) {
                    String approveUsername = request.getParameter("approveUsername");
                    String url = "jdbc:mysql://localhost:3306/user";
                    String dbUser = "root";
                    String dbPassword = "Murali@9405";
                    Connection conn = null;

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection(url, dbUser, dbPassword);
                        String updateStatusQuery = "UPDATE clients SET status='accepted' WHERE username=?";
                        PreparedStatement updateStatusStmt = conn.prepareStatement(updateStatusQuery);
                        updateStatusStmt.setString(1, approveUsername);
                        updateStatusStmt.executeUpdate();
                        out.println("<p>User " + approveUsername + " has been approved.</p>");
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (conn != null) {
                            try {
                                conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }

                if (request.getParameter("rejectUsername") != null) {
                    String rejectUsername = request.getParameter("rejectUsername");
                    String url = "jdbc:mysql://localhost:3306/user";
                    String dbUser = "root";
                    String dbPassword = "Murali@9405";
                    Connection conn = null;

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection(url, dbUser, dbPassword);
                        String deleteQuery = "DELETE FROM clients WHERE username=?";
                        PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery);
                        deleteStmt.setString(1, rejectUsername);
                        deleteStmt.executeUpdate();
                        out.println("<p>User " + rejectUsername + " has been rejected and deleted.</p>");
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (conn != null) {
                            try {
                                conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }

                if (request.getParameter("logout") != null) {
                    session.invalidate();
                    %>
                    <script>
                        showLoginForm();
                    </script>
                    <%
                    out.println("<h2>You have been logged out.</h2>");
                }
            %>
        </div>
   
    <br>
    <div class="footer">
        <p>&copy; 2025 Privacy Preservation In Multi Cloud Fusion</p>
    </div>
