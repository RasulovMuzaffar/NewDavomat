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
        <title>Талабалар давомати</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

         <!--Bootstrap--> 
        <link href="resources/css/bootstrap.min.css" rel="stylesheet">
        <link href="resources/css/adminstyle.css" rel="stylesheet">
        <link href="resources/css/justified-nav.css" rel="stylesheet">
        <script src="resources/js/jquery-3.2.0.min.js"></script>

         <!--HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries 
         WARNING: Respond.js doesn't work if you view the page via file:// 
        [if lt IE 9]>
        <script src="resources/scripts/html5shiv.js"></script>
        <script src="resources/scripts/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <div class="container-fluid">
            <h3>Талабалар давомати789789797</h3>
        </div>
        <div class="container-fluid">    
            <div id="d1">
            <input id="btn1" type="button" value="TableFromDB" onclick="www1('getBody', 1, 1);"/>
            <a href="newjsp.jsp">переход>>></a>
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
        </div>
        <script>
            function www1(p, id, semestr) {
                $.post('servlet', {command: p, id: id, semestr: semestr}, function (data) {
                    console.log(data);
                    document.getElementById("tbody1").innerHTML = data;
                });
            }
        </script>

         <!--jQuery (necessary for Bootstrap's JavaScript plugins)--> 
        <script src="resources/js/jquery-3.2.0.min.js"></script>
         <!--Include all compiled plugins (below), or include individual files as needed--> 
        <script src="resources/js/bootstrap.min.js"></script>
    </body>
</html>
