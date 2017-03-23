<%-- 
    Document   : index
    Created on : 23.03.2017, 10:02:20
    Author     : Muzaffar
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="resources/js/jquery-3.2.0.min.js" type="text/javascript"></script>
        <script src="resources/js/newjavascript.js" type="text/javascript"></script>
        <link href="css/styleIndex.css" rel="stylesheet" type="text/css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <div id="d1">
            <input id="btn" type="button" value="OK"/>
            <br/>
            <input id="btn1" type="button" value="TableFromDB" onclick="www1('getBody', 1, 1);"/>
        </div>
        <br/>
        <div id="d2">
            <table border="1" id="table1">
                <thead>
                    <tr>
                        <th rowspan="2">name</th>
                        <c:forEach begin="1" end="${weeks}">
                            <th colspan="2">weeks</th>  
                        </c:forEach>    
                        <th rowspan="2">Prop</th>
                        <th rowspan="2">uvProp</th>                      
                    </tr>
                    <tr>
                        <c:forEach begin="1" end="${weeks*2}">
                            <th>aa</th>
                        </c:forEach>
                    </tr>
                </thead>
                <tbody id="tbody1">           
                </tbody>
            </table>
        </div>
        <script>
            function www1(p, id, semestr) {
                $.post('servlet', {command: p, id: id, semestr: semestr}, function (data) {
                    console.log(data);
                    document.getElementById("tbody1").innerHTML = data;
                });
            }
        </script>
    </body>
</html>
