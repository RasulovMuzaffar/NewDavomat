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
        <style id="st">
            :root{
                --st : 36;
            }

            .sdx{
                width : calc(var(--w) * var(--st));
            }
        </style>

        <!-- Bootstrap -->
        <link href="resources/css/bootstrap.min.css" rel="stylesheet">
        <link href="resources/css/justified-nav.css" rel="stylesheet">
        <link href="resources/css/adminstyle.css" rel="stylesheet">


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
        </div>

        <div class="container-fluid">
            <div class="current_date"><strong>${uch_god} o'quv yili<br/><br/>${uch_semstr}-semestr</strong></div>
            <div class="tabs">
                <input id="tab1" type="radio" name="tabs" checked>
                <label for="tab1" title="I-kurs" onclick="getCources('getGr', 1, ${uch_semstr}, ${weeks1});">I-kurs</label>
                <input id="tab2" type="radio" name="tabs">
                <label for="tab2" title="II-kurs" onclick="getCources('getGr', 2, ${uch_semstr}, ${weeks2});">II-kurs</label>
                <input id="tab3" type="radio" name="tabs">
                <label for="tab3" title="III-kurs" onclick="getCources('getGr', 3, ${uch_semstr}, ${weeks3});">III-kurs</label>
                <input id="tab4" type="radio" name="tabs">
                <label for="tab4" title="IV-kurs" onclick="getCources('getGr', 4, ${uch_semstr}, ${weeks4});">IV-kurs</label>
                <section id="content-tab1" >
                    <ul class="nav nav-justified grps">
                        <c:forEach items="${groups}" var="g">
                            <li>
                                <a href="#" onclick="getStudents('getBody', ${g.id}, ${uch_semstr}, 1);">${g.name}</a>
                            </li>
                        </c:forEach>
                    </ul>

                    <br/>
                    <!--<section class="s">-->
                    <!--<div class="tContainer">-->
                    <!--                            <table class="table table-bordered table-striped">-->
                    <table class="table-bordered table-striped">
                        <thead>
                            <tr>
                                <th rowspan="4" class="n text-center">#</th>
                                <th rowspan="4" class="fio text-center">Familiyasi, Ismi, Sharifi</th>
                                <!--<th rowspan="4" class="text-center">Guruh</th>-->
                                <th rowspan="4" class="tip text-center"><div>G/K</div></th>
                                <th colspan="${weeks1*2}" class="sdx text-center">Semestr davomidagi xaftalar</th>
                                <th rowspan="4" class="summ text-center"><b>-</b></th>
                                <th rowspan="4" class="summ text-center" style="background-color: #00dc00;"><b>+</b></th>
                                <th rowspan="4" class="summ text-center" style="background-color: red;"><b>-</b></th>
                            </tr>
                            <tr>
                                <c:forEach var="i" begin="1" end="${weeks1}">
                                    <th class="numbW" colspan="2"><c:out value="${i}"/></th>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <c:forEach items="${d1}" var="d">
                                    <!--<th colspan="2" class="text-center">06.03 11.03</th>-->
                                    <th class="week" colspan="2" class="text-center">${d}</th>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <c:forEach items="${dDB1}" var="ddb">
                                    <th class="prps text-center" data-d="${ddb}">P</th><!--первый день недели-->
                                    <th class="prps text-center"  data-d="${ddb}" style="background-color: rgba(0,255,0,0.27)">U</th><!--первый день недели-->
                                    </c:forEach>
                            </tr>
                        </thead>
                        <tbody id="tbody1">
                        </tbody>
                    </table>
                    <!--</div>-->
                    <!--</section>-->
                </section>
                <section id="content-tab2">
                    <ul class="nav nav-justified grps"></ul>
                    <br/>
                    <table class="table-bordered table-striped">
                        <thead>
                            <tr>
                                <th rowspan="4" class="n text-center">#</th>
                                <th rowspan="4" class="fio text-center">Familiyasi, Ismi, Sharifi</th>
                                <!--<th rowspan="4" class="text-center">Guruh</th>-->
                                <th rowspan="4" class="tip text-center"><div>G/K</div></th>
                                <th colspan="${weeks2*2}" class="sdx text-center">Semestr davomidagi xaftalar</th>
                                <th rowspan="4" class="summ"><b>-</b></th>
                                <th rowspan="4" class="summ" style="background-color: #00dc00;"><b>+</b></th>
                                <th rowspan="4" class="summ" style="background-color: red;"><b>-</b></th>
                            </tr>
                            <tr>
                                <c:forEach var="i" begin="1" end="${weeks2}">
                                    <th class="numbW" colspan="2" class="text-center"><c:out value="${i}"/></th>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <c:forEach items="${d2}" var="d">
                                    <!--<th colspan="2" class="text-center">06.03 11.03</th>-->
                                    <th class="week" colspan="2" class="text-center">${d}</th>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <c:forEach items="${dDB2}" var="ddb">
                                    <th class="prps text-center" data-d="${ddb}">P</th><!--первый день недели-->
                                    <th class="prps text-center"  data-d="${ddb}" style="background-color: rgba(0,255,0,0.27)">U</th><!--первый день недели-->
                                    </c:forEach>
                            </tr>
                        </thead>
                        <tbody id="tbody2">
                        </tbody>
                    </table>
                </section>
                <section id="content-tab3">
                    <p>3 kurs</p>
                    <ul class="nav nav-justified grps"></ul>
                    <br/>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th rowspan="4" class="text-center">#</th>
                                <th rowspan="4" class="text-center">Familiyasi, Ismi, Sharifi</th>
                                <!--<th rowspan="4" class="text-center">Guruh</th>-->
                                <th rowspan="4" class="text-center">G/K</th>
                                <th colspan="${weeks3*2}" class="text-center">Semestr davomidagi xaftalar</th>
                                <th rowspan="4" class="text-center" style="font-size: 14pt"><b>-</b></th>
                                <th rowspan="4" class="text-center" style="background-color: #00dc00; font-size: 14pt"><b>+</b></th>
                                <th rowspan="4" class="text-center" style="background-color: red; font-size: 14pt"><b>-</b></th>
                            </tr>
                            <tr>
                                <c:forEach var="i" begin="1" end="${weeks3}">
                                    <th colspan="2" class="text-center"><c:out value="${i}"/></th>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <c:forEach items="${d3}" var="d3">
                                    <!--<th colspan="2" class="text-center">06.03 11.03</th>-->
                                    <th colspan="2" class="text-center">${d3}</th>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <c:forEach items="${dDB3}" var="ddb">
                                    <th class="text-center" data-d="${ddb}">P</th><!--первый день недели-->
                                    <th class="text-center"  data-d="${ddb}" style="background-color: rgba(0,255,0,0.27)">U</th><!--первый день недели-->
                                    </c:forEach>
                            </tr>
                        </thead>
                        <tbody id="tbody2">
                        </tbody>
                    </table>
                </section>
                <section id="content-tab4">
                    <p> 4 kurs</p>
                    <ul class="nav nav-justified grps"></ul>
                    <br/>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th rowspan="4" class="text-center">#</th>
                                <th rowspan="4" class="text-center">Familiyasi, Ismi, Sharifi</th>
                                <!--<th rowspan="4" class="text-center">Guruh</th>-->
                                <th rowspan="4" class="text-center">G/K</th>
                                <th colspan="${weeks4*2}" class="text-center">Semestr davomidagi xaftalar</th>
                                <th rowspan="4" class="text-center" style="font-size: 14pt"><b>&sum;</b></th>
                                <th rowspan="4" class="text-center" style="background-color: #00dc00; font-size: 14pt"><b>&sum;</b></th>
                                <th rowspan="4" class="text-center" style="background-color: red; font-size: 14pt"><b>&sum;</b></th>
                            </tr>
                            <tr>
                                <c:forEach var="i" begin="1" end="${weeks4}">
                                    <th colspan="2" class="text-center"><c:out value="${i}"/></th>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <c:forEach items="${d4}" var="d4">
                                    <!--<th colspan="2" class="text-center">06.03 11.03</th>-->
                                    <th colspan="2" class="text-center">${d4}</th>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <c:forEach items="${dDB4}" var="ddb">
                                    <th class="text-center" data-d="${ddb}">P</th><!--первый день недели-->
                                    <th class="text-center"  data-d="${ddb}" style="background-color: rgba(0,255,0,0.27)">U</th><!--первый день недели-->
                                    </c:forEach>
                            </tr>
                        </thead>
                        <tbody id="tbody4">
                        </tbody>
                    </table>
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

//                                    $(function () {
//                                        $('ul.nav.nav-justified li a').click(function () {
//                                            // удаляем класс .active у всех кнопок
//                                            $('ul.nav.nav-justified li').each(function () {
//                                                $(this).removeClass('active');
//                                            });
//                                            //добавляем для нажатой
//                                            $(this).parent().addClass('active');
//                                        });
//                                    });
                                    $(document).on('click', 'ul.nav.nav-justified li a', function () {
                                        // удаляем класс .active у всех кнопок
                                        $('ul.nav.nav-justified li').each(function () {
                                            $(this).removeClass('active');
                                        });
                                        //добавляем для нажатой
                                        $(this).parent().addClass('active');
                                    });
        </script>
        <!--///////-->
        <script>
            function getStudents(p, id, semestr, kursN) {
                console.log(p + " , " + id + " , " + semestr + " , " + kursN);
                $.post('servlet', {command: p, id: id, semestr: semestr}, function (data) {
                    console.log(data);
                    switch (kursN) {
                        case 1:
                            document.getElementById("tbody1").innerHTML = data;
                            break;
                        case 2:
                            document.getElementById("tbody2").innerHTML = data;
                            break;
                        case 3:
                            document.getElementById("tbody3").innerHTML = data;
                            break;
                        case 4:
                            document.getElementById("tbody4").innerHTML = data;
                            break;
                    }
                });
            }

            function getCources(p, kurs, sem, weeks) {
                $.post('servlet', {command: p, kurs: kurs, semestr: sem}, function (data) {
                    document.getElementById("st").innerHTML = ":root{--st : " + (weeks * 2) + ";} .sdx{width : calc(var(--w) * var(--st));}"
                    $('.grps').empty();
                    $('.grps').append(data);
                });
            }
        </script>

        <script src="resources/js/editPosesh.js" type="text/javascript"></script>

    </body>
</html>
