<%-- 
    Document   : bookadmin
    Created on : Mar 27, 2016, 8:22:40 PM
    Author     : Jackey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book Admin Home Page</title>
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
        var xmlHttp;
        xmlHttp = GetXmlHttpObject();
        
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
                        var t = document.createTextNode("InPrice");
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

                        var z = document.createElement("TH");
                        var t = document.createTextNode("Edit");
                        z.appendChild(t);
                        document.getElementById("myTr").appendChild(z);

                        var z = document.createElement("TH");
                        var t = document.createTextNode("Delete");
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
                            var t = document.createTextNode(json.booklist[count].inprice.toFixed(2));
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

                            var z = document.createElement("TD");
                            var a = document.createElement('a');
                            var id = json.booklist[count].bookid;
                            var linkText = document.createTextNode("Edit");
                            a.appendChild(linkText);
                            a.title = "Edit";
                            a.onclick = (function (id) {
                                return function () {
                                    selectRow(id);
                                };
                            })(id);
                            z.appendChild(a);
                            document.getElementById("myTr" + count).appendChild(z);

                            var z = document.createElement("TD");
                            var a = document.createElement('a');
                            var id = json.booklist[count].bookid;
                            var rowID = "myTr" + count;
                            var linkText = document.createTextNode("Delete");
                            a.appendChild(linkText);
                            a.title = "Delete";
                            a.onclick = (function (id, rowID) {
                                return function () {
                                    deleteRow(id, rowID);
                                };
                            })(id, rowID);
                            z.appendChild(a);
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
        
        function selectRow(bookID) {
            if (xmlHttp === null)
            {
                alert("Your browser does not support AJAX!");
                return;
            }
            console.log("bookID:"+bookID);
            var query = "todo=select&book="+bookID;
            
            xmlHttp.onreadystatechange = function stateChanged()
            {
                if (xmlHttp.readyState === 4)
                {
                    document.getElementById("editform").reset();
//                    document.getElementById("bookname").value='';
//                    document.getElementById("author").value='';
//                    document.getElementById("publisher").value='';
//                    document.getElementById("date").value='';
//                    document.getElementById("inprice").value='';
//                    document.getElementById("outprice").value='';
//                    document.getElementById("quantity").value='';
//                    document.getElementById("bookid").value='';
                    console.log("FORM RESET");
                    document.getElementById("editdiv").style.display = "block";
//                   console.log(v);
//                    var s = xmlHttp.responseText;
//                    var myObject = eval('(' + s + ')');
//                    
//                    alert(myObject["bookid"]);
//                    
//                    var json = JSON.parse(xmlHttp.responseText);
//                    
//                    console.log("**bookname:"+jQuery.parseJSON(json.book.bookname));
//                    console.log("**bookid:"+jQuery.parseJSON(json.book.bookid));
//                    document.getElementById("book_id").value = json.book.bookid;
//                    document.getElementById("bookname").value = eval(json.book.bookname);
//                    document.getElementById("author").value = eval(json.book.author);
//                    document.getElementById("publisher").value = eval(json.book.publisher);
//                    document.getElementById("date").value = eval(json.book.date);
//                    document.getElementById("inprice").value = eval(json.book.inprice);
//                    document.getElementById("outprice").value = eval(json.book.outprice);
//                    document.getElementById("quantity").value = eval(json.book.quantity);
                }
            };
            xmlHttp.open("POST", "book.htm", true);
            xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xmlHttp.send(query);
            return false;
        }
        
        function deleteRow(bookID, rowID) {
            if (xmlHttp === null)
            {
                alert("Your browser does not support AJAX!");
                return;
            }

            var query = "todo=delete&book=" + bookID;

            xmlHttp.onreadystatechange = function stateChanged()
            {
                if (xmlHttp.readyState === 4)
                {
                    var row = document.getElementById(rowID);
                    row.parentNode.removeChild(row);
                }
            };
            xmlHttp.open("POST", "book.htm", true);
            xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xmlHttp.send(query);
            return false;
        }
       
        function searchBookDisplay(){
            document.getElementById("editdiv").style.display = "none";
            document.getElementById("search").reset();
            document.getElementById("searchdiv").style.display = "block";
        }
        
        function getResults(){
            if (xmlHttp === null)
            {
                alert("Your browser does not support AJAX!");
                return;
            }
            var key = document.getElementById("keyid").value;
            var flag = document.querySelector('input[name = "search"]:checked').value;
            var query = "todo=searchuser&key=" + key.trim() + "&flag=" + flag.trim();
            xmlHttp.onreadystatechange = function stateChanged()
            {
                if (xmlHttp.readyState === 4)
                {
                    document.getElementById("bookdiv").innerHTML = "";
                    var json = JSON.parse(xmlHttp.responseText);
                    
                }
            };
            xmlHttp.open("POST", "book.htm", true);
            xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xmlHttp.send(query);
            return false;
        }
        
        function processRequest(){
            if (xmlHttp === null)
            {
                alert("Your browser does not support AJAX!");
                return;
            }
            var query = "todo=viewmessage";
            xmlHttp.onreadystatechange = function stateChanged()
            {
                if (xmlHttp.readyState === 4)
                {
                    document.getElementById("bookdiv").innerHTML = "";
                    console.log(xmlHttp.responseText);
                    var json = JSON.parse(xmlHttp.responseText);
                    if(json.msglist.length > 0){
                        var x = document.createElement("TABLE");
                        x.setAttribute("id", "msgTable");
                        document.getElementById("bookdiv").appendChild(x);
                        var y = document.createElement("TR");
                        y.setAttribute("id", "myTr");
                        document.getElementById("msgTable").appendChild(y);

                        var z = document.createElement("TH");
                        var t = document.createTextNode("Id");
                        z.appendChild(t);
                        document.getElementById("myTr").appendChild(z);
                        
                        var z = document.createElement("TH");
                        var t = document.createTextNode("Book Name");
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
                        var t = document.createTextNode("Request Date");
                        z.appendChild(t);
                        document.getElementById("myTr").appendChild(z);
                        
                        for(var count = 0; count < json.msglist.length; count++){
                            var y = document.createElement("TR");
                            y.setAttribute("id", "myTr" + count);
                            document.getElementById("msgTable").appendChild(y);

                            var z = document.createElement("TD");
                            var t = document.createTextNode(json.msglist[count].messageid);
                            z.appendChild(t);
                            document.getElementById("myTr" + count).appendChild(z);
                            
                            var z = document.createElement("TD");
                            var t = document.createTextNode(json.msglist[count].bookname);
                            z.appendChild(t);
                            document.getElementById("myTr" + count).appendChild(z);
                            
                            var z = document.createElement("TD");
                            var t = document.createTextNode(json.msglist[count].bookauthor);
                            z.appendChild(t);
                            document.getElementById("myTr" + count).appendChild(z);
                            
                            var z = document.createElement("TD");
                            var t = document.createTextNode(json.msglist[count].bookpublisher);
                            z.appendChild(t);
                            document.getElementById("myTr" + count).appendChild(z);
                            
                            var z = document.createElement("TD");
                            var t = document.createTextNode(json.msglist[count].date);
                            z.appendChild(t);
                            document.getElementById("myTr" + count).appendChild(z);
                        }
                    }
                    else{
                        document.getElementById("bookdiv").innerHTML="No Message";
                    }
                }
            };
            xmlHttp.open("POST", "message.htm", true);
            xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xmlHttp.send(query);
        }
    </script>
    <body>
        <h2>Hi, <b><font color="red">${sessionScope.user.getFirst()}</font></b></h2>
        <h4>You are logged in as <b><font color="red">${sessionScope.user.getRole()}</font></b></h4>
        <h2><b><font color="red">${successmsg}</font></b></h2>
        <button onclick="viewBook()">View All Books</button> &nbsp;&nbsp;
        <button onclick="searchBookDisplay()">Search a book</button> &nbsp;&nbsp;
        <button onclick="processRequest()">View Reader Message</button> <br><br>
        
        <div id="bookdiv">
        </div>
        <div id="editdiv" style="display: none">
            <form id="editform" action="book.htm" method="POST">
                Book Name:<input type="text" id="bookname" name="bookname" value="${sessionScope.sebook.getBookname()}" required />
                Author: <input type="text" id="author" name="author" value="${sessionScope.sebook.getAuthor()}" required />
                Publisher: <input type="text" id="publisher" name="publisher" value="${sessionScope.sebook.getPublisher()}" required />
                Date: <input type="text" id="date" name="date" pattern="^\d{4}-\d{2}-\d{2}$" value="${sessionScope.sebook.getDate()}" required />
                Inprice: <input type="text" id="inprice" pattern="^[1-9]\d?\d?\d?\.?\d?\d?$" name="inprice" value="${sessionScope.sebook.getInprice()}" required />
                Outprice: <input type="text" id="outprice" name="outprice" pattern="^[1-9]\d?\d?\d?\.?\d?\d?$" value="${sessionScope.sebook.getOutprice()}" required />
                Quantity: <input type="text" id="quantity" name="quantity" pattern="^[1-9]\d?\d?\d?\d?\d?$" value="${sessionScope.sebook.getQuantity()}" required />
                <input type="hidden" name="todo" value="editbook" />
                <input type="hidden" id="book_id" name="book_id" value="${sessionScope.sebook.getBookid()}" />
                <input type="submit" name="Confirm"/><br><br>
            </form>
        </div>
        <div id="searchdiv" style="display: none">
            <form id="search" onsubmit="return getResults();">
                <label>Search By:</label>
                <input type="radio" name="search" value="bookname" checked="checked"> Book Name
                <input type="radio" name="search"  value="author"> Author
                <input type="radio" name="search"  value="publisher"> Publisher <br><br>
                <input type="text" id="keyid" name="key" required />
                <input type="submit" name="Search"/><br><br>
            </form>
        </div>
        <div class="topcorner">
            <form action="process.htm" method="POST">
                <input type="submit" value="Logout" />
            </form>
        </div>
    </body>
</html>
