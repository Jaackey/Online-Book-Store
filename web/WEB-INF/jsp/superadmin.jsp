<%-- 
    Document   : superadmin
    Created on : Mar 27, 2016, 8:22:12 PM
    Author     : Jackey
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Super Admin Home Page</title>
    </head>
    <style>
        table{
            border:2px solid black;
        }
        a{
            text-decoration: underline;
            cursor: pointer;
            color:blue;
        }
        tr{
            border:1px solid black;
        }
        td{
            border:1px solid black;
        }
    </style>
    <style type="text/css">
     div.topcorner{
       position:absolute;
       top:0;
       right:0;
      }
    </style>
    <script>
        function createBookAdminDisplay(){
            if(document.getElementById("creatediv").style.display === "none"){
                document.getElementById("creatediv").style.display = "block";
                document.getElementById("createForm").reset();
                document.getElementById("processdiv").style.display = "none";
            }else {
                document.getElementById("creatediv").style.display = "none";
            }
        }
        
        function processBookDisplay(){
            if(document.getElementById("processdiv").style.display === "none"){
                document.getElementById("processdiv").style.display = "block";
                document.getElementById("processForm").reset();
                document.getElementById("creatediv").style.display = "none";
            }else {
                document.getElementById("processdiv").style.display = "none";
            }
        }
        
        var xmlHttp;
        xmlHttp = GetXmlHttpObject();
        function getResults(){
            if (xmlHttp === null)
            {
                alert("Your browser does not support AJAX!");
                return;
            }
            if(document.getElementById("recorddiv").style.display === "none"){
                var query = "page=1";
                xmlHttp.onreadystatechange = function stateChanged(){
                    if(xmlHttp.readyState === 4){
                        document.getElementById("recorddiv").innerHTML = "";
                        console.log(xmlHttp.responseText);
                        var json = JSON.parse(xmlHttp.responseText);
                        if(json.recordlist.length > 0){
                            var x = document.createElement("TABLE");
                            x.setAttribute("id", "recordTable");
                            document.getElementById("recorddiv").appendChild(x);
                            var y = document.createElement("TR");
                            y.setAttribute("id", "myTr");
                            document.getElementById("recordTable").appendChild(y);

                            var z = document.createElement("TH");
                            var t = document.createTextNode("Id");
                            z.appendChild(t);
                            document.getElementById("myTr").appendChild(z);

                            var z = document.createElement("TH");
                            var t = document.createTextNode("Type");
                            z.appendChild(t);
                            document.getElementById("myTr").appendChild(z);

                            var z = document.createElement("TH");
                            var t = document.createTextNode("Money");
                            z.appendChild(t);
                            document.getElementById("myTr").appendChild(z);

                            var z = document.createElement("TH");
                            var t = document.createTextNode("Date");
                            z.appendChild(t);
                            document.getElementById("myTr").appendChild(z);
                            
                            for(var count = 0; count < json.recordlist.length; count++){
                                var y = document.createElement("TR");
                                y.setAttribute("id", "myTr" + count);
                                document.getElementById("recordTable").appendChild(y);
                                
                                var z = document.createElement("TD");
                                var t = document.createTextNode(json.recordlist[count].recordid);
                                z.appendChild(t);
                                document.getElementById("myTr" + count).appendChild(z);
                                
                                var z = document.createElement("TD");
                                var t = document.createTextNode(json.recordlist[count].type);
                                z.appendChild(t);
                                document.getElementById("myTr" + count).appendChild(z);
                                
                                var z = document.createElement("TD");
                                var t = document.createTextNode(json.recordlist[count].money.toFixed(2));
                                z.appendChild(t);
                                document.getElementById("myTr" + count).appendChild(z);
                                
                                var z = document.createElement("TD");
                                var t = document.createTextNode(json.recordlist[count].date);
                                z.appendChild(t);
                                document.getElementById("myTr" + count).appendChild(z);
                            }
                        }
                        else{
                            document.getElementById("recorddiv").innerHTML="No Record";
                        }
                    }
                };
                xmlHttp.open("POST", "record.htm", true);
                xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xmlHttp.send(query);
                document.getElementById("recorddiv").style.display = "block";
                document.getElementById("creatediv").style.display = "none";
                document.getElementById("processdiv").style.display = "none";
            }else {
                document.getElementById("recorddiv").style.display = "none";
            }
        }
        
        function GetXmlHttpObject()
        {
            var xmlHttp = null;
            try
            {
                // Firefox, Opera 8.0+, Safari
                xmlHttp = new XMLHttpRequest();
            } catch (e)
            {
                // Internet Explorer
                try
                {
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                } catch (e)
                {
                    xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
            }
            return xmlHttp;
        }

    </script>
    <body>
        <h2>Hi, <b><font color="red">${sessionScope.user.getFirst()}</font></b></h2>
        <h4>You are logged in as <b><font color="red">${sessionScope.user.getRole()}</font></b></h4>
        <h2><b><font color="red">${msg}</font></b></h2>
        <button onclick="createBookAdminDisplay()">Create a bookadmin</button> &nbsp;&nbsp;
        <button onclick="processBookDisplay()">Process book purchase</button>&nbsp;&nbsp;
        <button onclick="getResults()">View Store Funding</button><br><br>
        <div id="creatediv" style="display: none">
            <form action="user.htm" id="createForm" method="POST">
                <p>Username: </p><input name="username" type="text" required="required"/><br><br>

                <p>Password: </p><input name="password" type="text" required="required"/><br><br>
                
                <p>Email: </p><input name="email" type="text"/><br><br>

                <p>First Name: </p><input name="firstname" type="text"/><br><br>

                <p>Last Name: </p><input name="lastname" type="text"/><br><br>
                
                <p>Address: </p><input name="address" type="text"/><br><br>
                
                <input type="hidden" name="todo" value="register" />
                
                <input type="hidden" name="role" value="bookadmin" />
                
                <input type="submit" name="Register" />

            </form>
        </div>
        
        <div id="processdiv" style="display: none">
            <form action="book.htm" id="processForm" method="POST"> 
                <p>Book Name: </p><input name="bookname" type="text" required="required"/><br><br>

                <p>Author: </p><input name="author" type="text" required="required"/><br><br>
                
                <p>Publisher: </p><input name="publisher" type="text" required="required"/><br><br>
                <p>Date: </p><input name="date" type="text" pattern="^\d{4}-\d{2}-\d{2}$" required="required"/><br><br>
                <p>In price: </p><input name="inprice" type="text" pattern="^[1-9]\d?\d?\d?\.?\d?\d?$" required="required"/><br><br>
                <p>Out price: </p><input name="outprice" type="text" pattern="^[1-9]\d?\d?\d?\.?\d?\d?$" required="required"/><br><br>
                <p>Quantity: </p><input name="quantity" type="text" pattern="^[1-9]\d?\d?\d?\d?\d?$" required="required"/><br><br>
                <input type="hidden" name="todo" value="newbook" />
                <input type="submit" name="Confirm" />
            </form>
        </div>
        <div class="topcorner">
            <form action="process.htm" method="POST">
                <input type="submit" value="Logout" />
            </form>
        </div>
        <div id="recorddiv" style="display: none">
        </div>
    </body>
</html>
