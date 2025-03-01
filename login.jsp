<%@ page import="java.sql.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
    body { font-family: Arial, sans-serif; margin: 0; padding: 0; background: url('background.jpg') no-repeat center center fixed; background-size: cover; } .navbar, .footer { background: rgba(255, 255, 255, 0.3); padding: 1em; text-align: center; backdrop-filter: blur(10px); } .navbar a { margin: 0 1em; color: black; text-decoration: none; font-size: 1.2em; font-weight: bold; } .container { display: flex; justify-content: center; align-items: center; height: 80vh; } .form-container { background: rgba(255, 255, 255, 0.3); padding: 2em; border-radius: 10px; backdrop-filter: blur(10px); text-align: center; } .form-container input { margin: 1em 0; padding: 1em; border: none; border-radius: 5px; width: 80%; } .form-container button { padding: 1em 2em; border: none; border-radius: 5px; cursor: pointer; background: rgba(0, 0, 0, 0.7); color: white; font-size: 1em; } .form-container button:hover { background: rgba(0, 0, 0, 0.9); } 
    </style>
</head>
<body>
    <div class="navbar">
        <h1>Privacy Preservation In Multi Cloud Fusion</h1> <br>
        <nav>
            <a href="index.jsp">Home</a>
        </nav>
    </div>
    <div class="container">
        <div class="form-container">
<%
    boolean isAuthenticated = false;
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user", "root", "Murali@9405");
            String sql = "SELECT username, fullname, password, email, gender, phone, address, status FROM clients WHERE username = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                String status = rs.getString("status");

                MessageDigest md = MessageDigest.getInstance("SHA-256");
                byte[] hash = md.digest(password.getBytes("UTF-8"));
                StringBuilder hexString = new StringBuilder();
                for (byte b : hash) {
                    String hex = Integer.toHexString(0xff & b);
                    if (hex.length() == 1) hexString.append('0');
                    hexString.append(hex);
                }
                String encryptedPassword = hexString.toString();

                if (storedPassword.equals(encryptedPassword)) {
                    if ("pending".equalsIgnoreCase(status)) {
                        out.println("<p style='color:red;'>Your account is still pending for approval. Please contact Admin.</p>");
                    } else if ("rejected".equalsIgnoreCase(status)) {
                        String deleteSql = "DELETE FROM clients WHERE username = ?";
                        PreparedStatement deletePstmt = conn.prepareStatement(deleteSql);
                        deletePstmt.setString(1, username);
                        deletePstmt.executeUpdate();
                        out.println("<p style='color:red;'>Your account has been rejected. Please contact support for further information.</p>");
                        deletePstmt.close();
                    } else if ("accepted".equalsIgnoreCase(status)) {
                        isAuthenticated = true;
                        session.setAttribute("username", rs.getString("username"));
                        session.setAttribute("fullname", rs.getString("fullname"));
                        session.setAttribute("email", rs.getString("email"));
                        session.setAttribute("gender", rs.getString("gender"));
                        session.setAttribute("phone", rs.getString("phone"));
                        session.setAttribute("address", rs.getString("address"));
                    }
                } else {
                    out.println("<p style='color:red;'>Invalid username or password</p>");
                }
            } else {
                out.println("<p style='color:red;'>Invalid username or password</p>");
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

    if (!isAuthenticated) {
%>
            <h2>Login</h2>
            <form action="login.jsp" method="post">
                <input type="text" id="login-username" name="username" placeholder="Username" required>
                <input type="password" id="login-password" name="password" placeholder="Password" required>
                <button type="submit">Login</button>
            </form>
<%
    } else {
        response.sendRedirect("Welcome.jsp");
    }
%>
        </div>
    </div>
    <div class="footer">
        <p>&copy; 2025 Privacy Preservation In Multi Cloud Fusion</p>
    </div>
</body>
</html>
