<!DOCTYPE html>
<%-- 
    Document   : newjsp
    Created on : 24.04.2017, 16:16:15
    Author     : Muzaffar
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Талабалар давомати</title>

        <!-- Bootstrap -->
        <link href="resources/css/bootstrap.min.css" rel="stylesheet">
        <link href="resources/css/adminstyle.css" rel="stylesheet">
        <link href="resources/css/justified-nav.css" rel="stylesheet">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="resources/scripts/html5shiv.js"></script>
        <script src="resources/scripts/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <div class="container-fluid">
            <h3>Талабалар давомати</h3>
            <a href="newjsp1.jsp">goto ->>></a>
        </div>

        <div class="container-fluid">
            <div class="current_date"><strong>${uch_god} o'quv yili<br/><br/>${uch_semstr}-semestr</strong></div>
            <div class="tabs">
                <input id="tab1" type="radio" name="tabs" checked>
                <label for="tab1" title="I-kurs">I-kurs</label>
                <input id="tab2" type="radio" name="tabs">
                <label for="tab2" title="II-kurs">II-kurs</label>
                <input id="tab3" type="radio" name="tabs">
                <label for="tab3" title="III-kurs">III-kurs</label>
                <input id="tab4" type="radio" name="tabs">
                <label for="tab4" title="IV-kurs">IV-kurs</label>
                <section id="content-tab1">
                    <ul class="nav nav-justified">
                        <c:forEach items="${groups}" var="g">
                            <li>
                                <a href="#" onclick="www1('getBody', ${g.id}, ${uch_semstr});">${g.name}</a>
                            </li>
                        </c:forEach>
                    </ul>



                    <br/>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th rowspan="4" class="text-center">#</th>
                                <th rowspan="4" class="text-center">Familiyasi, Ismi, Sharifi</th>
                                <!--<th rowspan="4" class="text-center">Guruh</th>-->
                                <th rowspan="4" class="text-center">G/K</th>
                                <th colspan="${weeks*2}" class="text-center">Semestr davomidagi xaftalar</th>
                                <th rowspan="4" class="text-center" style="font-size: 14pt"><b>&sum;</b></th>
                                <th rowspan="4" class="text-center" style="background-color: #00dc00; font-size: 14pt"><b>&sum;</b></th>
                                <th rowspan="4" class="text-center" style="background-color: red; font-size: 14pt"><b>&sum;</b></th>
                            </tr>
                            <tr>
                                <c:forEach var="i" begin="1" end="${weeks}">
                                    <th colspan="2" class="text-center"><c:out value="${i}"/></th>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <c:forEach begin="1" end="${weeks}">
                                    <th colspan="2" class="text-center">06.03 11.03</th>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <c:forEach begin="1" end="${weeks}">
                                    <th class="text-center">U</th>
                                    <th class="text-center" style="background-color: rgba(0,255,0,0.27)">S</th>
                                    </c:forEach>
                            </tr>
                        </thead>
                        <tbody id="tbody1">
                        </tbody>
                    </table>
                </section>
                <section id="content-tab2">
                    <p> 2 kurs</p>
                </section>
                <section id="content-tab3">
                    <p>3 kurs</p>
                </section>
                <section id="content-tab4">
                    <p> 4 kurs</p>
                </section>
            </div>
            <!--<div class="info"> сделано с любовью: <a href="http://twitter.com/dobrovoi"><i class="fa fa-heart"></i> dobrovoi</a> </div>-->
        </div>

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="resources/js/jquery-3.2.0.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="resources/js/bootstrap.min.js"></script>

        <!--///скрипт для перехода по группам///-->
        <script>
                                $(function () {
                                    $('ul.nav.nav-justified li a').click(function () {
                                        // удаляем класс .active у всех кнопок
                                        $('ul.nav.nav-justified li').each(function () {
                                            $(this).removeClass('active');
                                        });
                                        //добавляем для нажатой
                                        $(this).parent().addClass('active');
                                    });
                                });
        </script>
        <!--///////-->
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
