<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to Online Book Store</title>
    </head>
    <script>
        function loginFormDisplay(){
            if(document.getElementById("logindiv").style.display == "none"){
                document.getElementById("logindiv").style.display = "block";
                document.getElementById("loginForm").reset();
                document.getElementById("registerdiv").style.display = "none";
            }else {
                document.getElementById("logindiv").style.display = "none";
            }
        }
        
        function registerFormDisplay(){
            if(document.getElementById("registerdiv").style.display == "none"){
                document.getElementById("registerdiv").style.display = "block";
                document.getElementById("registerForm").reset();
                document.getElementById("logindiv").style.display = "none";
            }else {
                document.getElementById("registerdiv").style.display = "none";
            }
        }
    </script>
    <body>
        <h3>Welcome to Online Book Store</h3>
        <p>Please login your account or register a new account.</p>
        <button onclick="loginFormDisplay()">I have an account.</button><br><br>
        <button onclick="registerFormDisplay()">I am new here.</button><br><br>
        <div id="registerdiv" style="display: none">
            <!--<span id="registererror"></span>-->
            <form action="user.htm" id="registerForm" method="POST">
                <p>Username: </p><input name="username" type="text" required="required"/><br><br>

                <p>Password: </p><input name="password" type="text" required="required"/><br><br>
                
                <p>You can also edit the following information in future.</p><br><br>

                <p>Email: </p><input name="email" type="email"/><br><br>

                <p>First Name: </p><input name="firstname" type="text"/><br><br>

                <p>Last Name: </p><input name="lastname" type="text"/><br><br>
                
                <p>Address: </p><input name="address" type="text"/><br><br>
                
                <input type="hidden" name="todo" value="register" />
                
                <input type="hidden" name="role" value="reader" />
                
                <input type="submit" name="Register" />

            </form>
        </div>
        <div id="logindiv" style="display: none">
            <!--<span id="loginerror"></span>-->
            <form action="user.htm" id="loginForm" method="POST">
                <p>Username: </p><input name="username" type="text" required="required"/><br><br>

                <p>Password: </p><input name="password" type="text" required="required"/><br><br>

                <input type="hidden" name="todo" value="login" />
                
                <input type="submit" name="Login">

            </form>
        </div>
    </body>
</html>
