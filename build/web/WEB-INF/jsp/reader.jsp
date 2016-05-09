<%-- 
    Document   : reader
    Created on : Mar 27, 2016, 8:19:27 PM
    Author     : Jackey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reader Home Page</title>
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
        function editInfoDisplay(){
            if(document.getElementById("editinfodiv").style.display === "none"){
                document.getElementById("editinfodiv").style.display = "block";
                document.getElementById("editinfoForm").reset();
                document.getElementById("searchdiv").style.display = "none";
                document.getElementById("requestdiv").style.display = "none";
            }else {
                document.getElementById("editinfodiv").style.display = "none";
            }
        }
        
        function searchBookDisplay(){
            if(document.getElementById("searchdiv").style.display === "none"){
                document.getElementById("searchdiv").style.display = "block";
                document.getElementById("searchform").reset();
                document.getElementById("editinfodiv").style.display = "none";
                document.getElementById("requestdiv").style.display = "none";
            }else {
                document.getElementById("searchdiv").style.display = "none";
            }
        }
        
        function requestBookDisplay(){
            if(document.getElementById("requestdiv").style.display === "none"){
                document.getElementById("requestdiv").style.display = "block";
                document.getElementById("requestForm").reset();
                document.getElementById("searchdiv").style.display = "none";
                document.getElementById("editinfodiv").style.display = "none";
            }else {
                document.getElementById("requestdiv").style.display = "none";
            }
        }
        
        var xmlHttp;
        xmlHttp = GetXmlHttpObject();
        
        function purchase(r){
            if (xmlHttp === null)
            {
                alert("Your browser does not support AJAX!");
                return;
            }
            var row = r.parentNode.parentNode.rowIndex;
            console.log("***row:"+row);
            var bookid = document.getElementById("searchResultTable").rows[row].cells[0].children[0].value;
//            bookid.replace(/\/$/, "");
//            bookid = bookid.substr(0, bookid.length-1);
            console.log("***bookid:"+bookid);
            var query = "todo=purchase&bookid="+bookid;
            xmlHttp.onreadystatechange = function stateChanged(){
                if(xmlHttp.readyState === 4){
                    alert("You have purchased successfully!");
                }
            };
            xmlHttp.open("POST", "book.htm", true);
            xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xmlHttp.send(query);
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
        
        function viewOrder(userid){
            if (xmlHttp === null)
            {
                alert("Your browser does not support AJAX!");
                return;
            }
            var query="todo=vieworder&userid="+userid;
            xmlHttp.onreadystatechange = function stateChanged(){
                if(xmlHttp.readyState === 4){
                    document.getElementById("vieworderdiv").innerHTML = "";
                    console.log(xmlHttp.responseText);
                    var json = JSON.parse(xmlHttp.responseText);
                    if(json.orderlist.length > 0){
                        var x = document.createElement("TABLE");
                        x.setAttribute("id", "orderTable");
                        document.getElementById("vieworderdiv").appendChild(x);
                        var y = document.createElement("TR");
                        y.setAttribute("id", "myTr");
                        document.getElementById("orderTable").appendChild(y);
                        
                        var z = document.createElement("TH");
                        var t = document.createTextNode("Id");
                        z.appendChild(t);
                        document.getElementById("myTr").appendChild(z);

                        var z = document.createElement("TH");
                        var t = document.createTextNode("Book Name");
                        z.appendChild(t);
                        document.getElementById("myTr").appendChild(z);

                        var z = document.createElement("TH");
                        var t = document.createTextNode("Price");
                        z.appendChild(t);
                        document.getElementById("myTr").appendChild(z);

                        var z = document.createElement("TH");
                        var t = document.createTextNode("Date");
                        z.appendChild(t);
                        document.getElementById("myTr").appendChild(z);
                        for(var count = 0; count < json.orderlist.length; count++){
                            var y = document.createElement("TR");
                            y.setAttribute("id", "myTr" + count);
                            document.getElementById("orderTable").appendChild(y);
                            
                            var z = document.createElement("TD");
                            var t = document.createTextNode(json.orderlist[count].orderid);
                            z.appendChild(t);
                            document.getElementById("myTr" + count).appendChild(z);

                            var z = document.createElement("TD");
                            var t = document.createTextNode(json.orderlist[count].books[0].bookname);
                            z.appendChild(t);
                            document.getElementById("myTr" + count).appendChild(z);

                            var z = document.createElement("TD");
                            var t = document.createTextNode(json.orderlist[count].books[0].outprice.toFixed(2));
                            z.appendChild(t);
                            document.getElementById("myTr" + count).appendChild(z);

                            var z = document.createElement("TD");
                            var t = document.createTextNode(json.orderlist[count].date);
                            z.appendChild(t);
                            document.getElementById("myTr" + count).appendChild(z);
                        }
                    }
                    else{
                        document.getElementById("vieworderdiv").innerHTML="No Order";
                    }
                }
            };
            xmlHttp.open("POST", "book.htm", true);
            xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xmlHttp.send(query);
        }
        
        function viewBook(pageNum){
            if (xmlHttp === null)
            {
                alert("Your browser does not support AJAX!");
                return;
            }
//            var pageNum = '${pageNum}';
//            var pm = Number(pageNum);
            if(pageNum===undefined){
                pageNum = 1;
            }
            console.log(pageNum);
            var query = "todo=view&pageNum="+pageNum;
            
            xmlHttp.onreadystatechange = function stateChanged(){
              if(xmlHttp.readyState === 4){
                    document.getElementById("bookdiv").innerHTML = "";
                    var json = JSON.parse(xmlHttp.responseText);
                    if(json.booklist.length > 0){
                        var x = document.createElement("TABLE");
                        x.setAttribute("id", "bookTable");
                        document.getElementById("bookdiv").appendChild(x);
                        var y = document.createElement("TR");
                        y.setAttribute("id", "myTr");
                        document.getElementById("bookTable").appendChild(y);

                        var z = document.createElement("TH");
                        var t = document.createTextNode("Id");
                        z.appendChild(t);
                        document.getElementById("myTr").appendChild(z);

                        var z = document.createElement("TH");
                        var t = document.createTextNode("Name");
                        z.appendChild(t);
                        document.getElementById("myTr").appendChild(z);

                        var z = document.createElement("TH");
                        var t = document.createTextNode("Author");
                        z.appendChild(t);
                        document.getElementById("myTr").appendChild(z);

                        var z = document.createElement("TH");
                        var t = document.createTextNode("Publisher");
                        z.appendChild(t);
                        document.getElementById("myTr").appendChild(z);

                        var z = document.createElement("TH");
                        var t = document.createTextNode("Date");
                        z.appendChild(t);
                        document.getElementById("myTr").appendChild(z);

                        var z = document.createElement("TH");
                        var t = document.createTextNode("OutPrice");
                        z.appendChild(t);
                        document.getElementById("myTr").appendChild(z);

                        var z = document.createElement("TH");
                        var t = document.createTextNode("Quantity");
                        z.appendChild(t);
                        document.getElementById("myTr").appendChild(z);

                        for(var count = 0; count < json.booklist.length; count++){
                            var y = document.createElement("TR");
                            y.setAttribute("id", "myTr" + count);
                            document.getElementById("bookTable").appendChild(y);

                            var z = document.createElement("TD");
                            var t = document.createTextNode(json.booklist[count].bookid);
                            z.appendChild(t);
                            document.getElementById("myTr" + count).appendChild(z);

                            var z = document.createElement("TD");
                            var t = document.createTextNode(json.booklist[count].bookname);
                            z.appendChild(t);
                            document.getElementById("myTr" + count).appendChild(z);

                            var z = document.createElement("TD");
                            var t = document.createTextNode(json.booklist[count].author);
                            z.appendChild(t);
                            document.getElementById("myTr" + count).appendChild(z);

                            var z = document.createElement("TD");
                            var t = document.createTextNode(json.booklist[count].publisher);
                            z.appendChild(t);
                            document.getElementById("myTr" + count).appendChild(z);

                            var z = document.createElement("TD");
                            var t = document.createTextNode(json.booklist[count].date);
                            z.appendChild(t);
                            document.getElementById("myTr" + count).appendChild(z);

                            var z = document.createElement("TD");
                            var t = document.createTextNode(json.booklist[count].outprice.toFixed(2));
                            z.appendChild(t);
                            document.getElementById("myTr" + count).appendChild(z);

                            var z = document.createElement("TD");
                            var t = document.createTextNode(json.booklist[count].quantity);
                            z.appendChild(t);
                            document.getElementById("myTr" + count).appendChild(z);

                            if(count === 9){
                                var br = document.createElement('br');
                                var a = document.createElement('a');
                                var nextPage = parseInt(pageNum) + 1;
                                var linkText = document.createTextNode("Next Page");
                                a.appendChild(linkText);
                                a.title = "Next_Page";
                                a.onclick = (function (nextPage) {
                                return function () {
                                    viewBook(nextPage);
                                };
                            })(nextPage);
                            document.getElementById("bookdiv").appendChild(br);
                            document.getElementById("bookdiv").appendChild(a);
                            }
                        }
                        if(pageNum>1){
                            var br = document.createElement('br');
                            var a = document.createElement('a');
                            var prePage = parseInt(pageNum) - 1;
                            var linkText = document.createTextNode("Previous Page");
                            a.appendChild(linkText);
                            a.title = "Prev_Page";
                            a.onclick = (function (prePage) {
                            return function () {
                                viewBook(prePage);
                            };
                            })(prePage);
                            document.getElementById("bookdiv").appendChild(br);
                            document.getElementById("bookdiv").appendChild(a);
                        }
                    }
                    else{
                        document.getElementById("bookdiv").innerHTML="No Record";
                        if(pageNum>1){
                            var br = document.createElement('br');
                            var a = document.createElement('a');
                            var prePage = parseInt(pageNum) - 1;
                            var linkText = document.createTextNode("Previous Page");
                            a.appendChild(linkText);
                            a.title = "Prev_Page";
                            a.onclick = (function (prePage) {
                            return function () {
                                viewBook(prePage);
                            };
                            })(prePage);
                            document.getElementById("bookdiv").appendChild(br);
                            document.getElementById("bookdiv").appendChild(a);
                        }
                    }
              }  
            };
            
            xmlHttp.open("POST", "book.htm", true);
            xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xmlHttp.send(query);
        }
        
    </script>
    <body>
        <h2>Hi, <b><font color="red">${sessionScope.user.getFirst()}</font></b></h2>
        <h4>You are logged in as <b><font color="red">${sessionScope.user.getRole()}</font></b></h4>
        
        <h2><b><font color="red">${msg}</font></b></h2>
        <h2><b><font color="red">${successmsg}</font></b></h2>
        <button onclick="viewBook()">View All Books</button> &nbsp;&nbsp;
        <button onclick="editInfoDisplay()">Edit User Info</button> &nbsp;&nbsp;
        <button onclick="viewOrder(${sessionScope.user.getUserid()})">View Order</button> &nbsp;&nbsp;
        <button onclick="searchBookDisplay()">Search Book</button> &nbsp;&nbsp;
        <button onclick="requestBookDisplay()">Request Book</button> <br><br>
        
        <div id="bookdiv">
        </div>
        
        <div id="editinfodiv" style="display: none">
            <form action="user.htm" id="editinfoForm" method="POST">
                <p>Username: </p><input name="username" type="text" value="${sessionScope.user.getUsername()}" disabled/><br><br>

                <p>Password: </p><input name="password" type="text" value="${sessionScope.user.getPassword()}" required="required"/><br><br>
                
                <p>Email: </p><input name="email" type="email" value="${sessionScope.user.getEmail()}" /><br><br>

                <p>First Name: </p><input name="firstname" type="text" value="${sessionScope.user.getFirst()}"/><br><br>

                <p>Last Name: </p><input name="lastname" type="text" value="${sessionScope.user.getLast()}" /><br><br>
                
                <p>Address: </p><input name="address" type="text" value="${sessionScope.user.getAddress()}" /><br><br>
                
                <input type="hidden" name="todo" value="editinfo" />
                
                <input type="hidden" name="role" value="reader" />
                
                <input type="submit" name="Update" />

            </form>
        </div>
                
        <div id="searchdiv" style="display: none">
            <form id="searchform" action="book.htm" method="POST">
                <label>Search By:</label>
                <input type="radio" name="search" value="bookname" checked="checked"> Book Name
                <input type="radio" name="search"  value="author"> Author
                <input type="radio" name="search"  value="publisher"> Publisher <br><br>
                <input type="text" id="keyid" name="key" required />
                <input type="hidden" name="todo" value="search" />
                <input type="submit" name="Search"/><br><br>
            </form>
        </div>
                
        <div id="requestdiv" style="display: none">
            <form action="message.htm" id="requestForm" method="POST"> 
                <p>Book Name: </p><input name="bookname" type="text" required="required"/><br><br>
                <p>Author: </p><input name="author" type="text" required="required"/><br><br>
                <p>Publisher: </p><input name="publisher" type="text" required="required"/><br><br>
                <input type="hidden" name="todo" value="addmessage" />
                <input type="submit" name="Confirm" />
            </form>
        </div>
                
        <c:choose>
            <c:when test="${!empty searchresult}">
                <table id="searchResultTable">
                    <tr>
                        <th>Book Id</th>
                        <th>Book Name</th>
                        <th>Author</th>
                        <th>Price</th>
                        <th>Date</th>
                        <th>Quantity</th>
                        <th>Purchase</th>
                    </tr>
                    <c:forEach items="${searchresult}" var="res">
                        <tr>
                            <td><input type="text" name="bookidcell" value="${res.getBookid()}" disabled /></td>
                            
                            <td>${res.getBookname()}</td>
                            <td>${res.getAuthor()}</td>
                            <td>${res.getOutprice()}</td>
                            <td>${res.getDate()}</td>
                            <td>${res.getQuantity()}</td>
                            <c:choose>
                                <c:when test="${res.getQuantity() < 1}">
                                    <td>Not Enough Quantity</td>
                                </c:when>
                                <c:otherwise>
                                    <td><input type="button" value="Purchase" onclick="purchase(this)"></td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:forEach>
                </table>
            </c:when>
        </c:choose>
        <div class="topcorner">
            <form action="process.htm" method="POST">
                <input type="submit" value="Logout" />
            </form>
        </div>
        <div id="vieworderdiv">
        </div>
    </body>
</html>
