<%@ page import="java.sql.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background: url('background.jpg') no-repeat center center fixed; background-size: cover; }
        .navbar, .footer { background: rgba(255, 255, 255, 0.3); padding: 1em; text-align: center; backdrop-filter: blur(10px); }
        .navbar a { margin: 0 1em; color: black; text-decoration: none; font-size: 1.2em; font-weight: bold; }
        .container { display: flex; justify-content: center; align-items: center; margin-top: 80px; margin-bottom: 80px; }
        .form-container { background: rgba(255, 255, 255, 0.3); padding: 2em; border-radius: 10px; backdrop-filter: blur(10px); width: 300px; }
        .form-container input { margin: 0.5em 0; padding: 1em; border: none; border-radius: 5px; width: 90%; }
        .form-container button { padding: 1em 2em; border: none; border-radius: 5px; cursor: pointer; background: rgba(0, 0, 0, 0.7); color: white; font-size: 1em; margin-top: 1em; }
        .form-container button:hover { background: rgba(0, 0, 0, 0.9); }
        .form-container label { margin: 1em 0; font-size: 1em; }
        .form-container .password-container { display: flex; align-items: center; justify-content: space-between; }
        .form-container .password-container input { width: 80%; }
    </style>
    <script>
        function validateForm() {
            var password = document.getElementById("reg-password").value;
            var confirmPassword = document.getElementById("reg-confirm-password").value;

            if (password !== confirmPassword) { 
                alert("Passwords do not match!");
                return false;
            }

            var passwordFormat = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$/;
            if (!password.match(passwordFormat)) {
                alert("Password must be at least 8 characters long and contain at least one letter and one number.");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
    <div class="navbar">
        <h1>Privacy Preservation In Multi Cloud Fusion</h1>
        <nav>
            <a href="index.jsp">Home</a>
        </nav>
    </div>
    <div class="container">
        <div class="form-container">
           <center> <h2 class="center" >Register-Form</h2></center>
            <form action="Rigister.jsp" method="post" onsubmit="return validateForm()">
                <input type="text" id="reg-fullname" name="fullname" placeholder="Full Name" required>
                <input type="text" id="reg-username" name="username" placeholder="Username" required>
                <input type="password" id="reg-password" name="password" placeholder="Password" required>
                <input type="password" id="reg-confirm-password" name="confirmPassword" placeholder="Confirm Password" required>
                <input type="email" id="reg-email" name="email" placeholder="Email" required>
                <input type="text" id="reg-gender" name="gender" placeholder="Gender" required>
                <input type="text" id="reg-phone" name="phone" placeholder="Phone" required>
                <input type="text" id="reg-address" name="address" placeholder="Address" required>
             <center><button class="center" type="submit">Register</button></center>
            </form>
<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes("UTF-8"));
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        String encryptedPassword = hexString.toString();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String status = "pending";
            Class.forName("com.mysql.cj.jdbc.Driver");

            String host = "mysql.railway.internal";
            String port = "3306";
            String database = "railway";
            String user = "root";
            String password = "mKHuZIscurswmblwMWeLePtZsxZiAPEN";

           String url = "jdbc:mysql://" + host + ":" + port + "/" + database;

            conn = DriverManager.getConnection(url, user, password);
            String checkEmailQuery = "SELECT email FROM clients WHERE email = ?";
            pstmt = conn.prepareStatement(checkEmailQuery);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            if (rs.next()) {
            	%>
            	    <script type="text/javascript">
            	        alert("An Account Already Exist With Provoded Email: <%= rs.getString("email") %>");
            	    </script>
            	<% } else {
                String sql = "INSERT INTO clients (fullname, username, password, email, gender, phone, address, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, fullname);
                pstmt.setString(2, username);
                pstmt.setString(3, encryptedPassword); 
                pstmt.setString(4, email);
                pstmt.setString(5, gender);
                pstmt.setString(6, phone);
                pstmt.setString(7, address);
                pstmt.setString(8, status);
                pstmt.executeUpdate();

                session.setAttribute("username", username);
                response.sendRedirect("login.jsp");
            }
        } catch (Exception e) { 
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>
        </div>
    </div>
    <div class="footer">
        <p>&copy; 2025 Privacy Preservation In Multi Cloud Fusion</p>
    </div>
</body>
</html>
