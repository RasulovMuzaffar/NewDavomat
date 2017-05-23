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
        <link href="resources/css/dataTables.bootstrap.min.css" rel="stylesheet">
        <link href="resources/css/justified-nav.css" rel="stylesheet">
        <link href="resources/css/test.css" rel="stylesheet">


        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="resources/scripts/html5shiv.js"></script>
        <script src="resources/scripts/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <ul class="nav nav-justified grps">
            <c:forEach items="${groups}" var="g">
                <li>
                    <a href="#" onclick="getStudents('getBody', ${g.id}, ${uch_semstr}, 1);">${g.name}</a>
                </li>
            </c:forEach>
        </ul>

        <br/>
        <table id="myTable1" class="table table-striped table-bordered" cellspacing="0" width="100%">
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

            $(document).ready(function () {
                $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                    $.fn.dataTable.tables({visible: true, api: true}).columns.adjust();
                });

                $('table.table').DataTable({
                    ajax: '../ajax/data/arrays.txt',
//getStudents('getBody', 1, 2, 1),
                    scrollY: 200,
                    scrollCollapse: true,
                    paging: false
                });

                // Apply a search to the second table for the demo
                $('#myTable2').DataTable().search('New York').draw();
            });
        </script>
        <script src="resources/js/getList.js" type="text/javascript"></script>
        <script src="resources/js/editPosesh.js" type="text/javascript"></script>

    </body>
</html>

