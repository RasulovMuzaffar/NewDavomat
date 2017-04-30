/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inst;

import com.mysql.jdbc.Connection;
import inst.pojo.SprGroup;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Muzaffar
 */
@WebServlet(name = "Servlet", urlPatterns = {"/servlet"})
public class Servlet extends HttpServlet {

    private static final String CONTENT_TYPE = "text/html; charset=UTF-8";
    static String uch_god;
    static String uch_semstr;
    private static final String URL = "jdbc:mysql://localhost:3306/students";
    private static final String USER = "root";
    private static final String PASS = "123456";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            response.setContentType(CONTENT_TYPE);
//            response.setCharacterEncoding("utf-8");
//            PrintWriter out = response.getWriter();
//            out.print("вроде работает!");

            Calendar c = new GregorianCalendar();
            if (c.get(Calendar.MONTH) < 8) {
                uch_god = (c.get(Calendar.YEAR) - 1) + "-" + c.get(Calendar.YEAR);
            } else {
                uch_god = c.get(Calendar.YEAR) + "-" + (c.get(Calendar.YEAR) + 1);
            }
            request.setAttribute("uch_god", uch_god);

            if (c.get(Calendar.MONTH) >= 0 && c.get(Calendar.MONTH) < 8) {
                uch_semstr = "" + 2;
            } else {
                uch_semstr = "" + 1;
            }
            request.setAttribute("uch_semstr", uch_semstr);

            Class.forName("com.mysql.jdbc.Driver");
//            try (Connection con = (Connection) DriverManager.getConnection(URL, USER, PASS);
//                    CallableStatement proc = con.prepareCall("{call procedure1(" + 1 + "," + Integer.parseInt(uch_semstr) + ")}");) {
//
//                ResultSet rs = proc.executeQuery();
//                rs.next();
//                int weeks = rs.getInt("weeksOnSem");
//                request.setAttribute("weeks", weeks);
//
//                int kursN = rs.getInt("kurs");
//                request.setAttribute("kursN", kursN);
//
//                Date startNed = rs.getDate("semesters");
//                request.setAttribute("d", getDaysOfWeeks(startNed, weeks));
//
//                request.setAttribute("startNed", startNed);
//
//                request.setAttribute("groups", getGroups(1, Integer.parseInt(uch_semstr)));
//
//                request.getRequestDispatcher("newjsp.jsp").forward(request, response);
////                response.sendRedirect("newjsp1.jsp");
//            } catch (SQLException ex) {
//                Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
//            }
//        } catch (ClassNotFoundException ex) {
//            Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
//        }

            try (Connection con = (Connection) DriverManager.getConnection(URL, USER, PASS);
                    CallableStatement proc = con.prepareCall("{call p2(" + Integer.parseInt(uch_semstr) + ")}");) {

                ResultSet rs = proc.executeQuery();
                int i = 1;
                while (rs.next()) {
                    int kurs = rs.getInt("kurs");
                    request.setAttribute("kurs" + i, kurs);
                    System.out.println("kurs" + i + " = " + kurs);
                    int weeks = rs.getInt("weeks");
                    request.setAttribute("weeks" + i, weeks);
                    System.out.println("weeks" + i + " = " + weeks);

                    Date startNed = rs.getDate("startNed");
                    request.setAttribute("d" + i, getDaysOfWeeks(startNed, weeks));
                    request.setAttribute("dDB" + i, getDaysOfWeeksToDB(startNed, weeks));
                    i++;
//                    System.out.println("ddb = " + getDaysOfWeeks(startNed, weeks));

                    List<SprGroup> sprG = getGroups(1, Integer.parseInt(uch_semstr));
                    request.setAttribute("groups", getGroups(1, Integer.parseInt(uch_semstr)));
//                    for (SprGroup s : sprG) {
//                        System.out.println(s.getId() + " , " + s.getName() + " , " + s.getIdFac());
//                    }

//                    i++;
                }

            } catch (SQLException ex) {
                Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.getRequestDispatcher("newjsp.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType(CONTENT_TYPE);
        PrintWriter out = response.getWriter();
        String command;
        int id = 0;
        int semestr = 0;
        int cource = 0;
        String data = null;
        int znach = 0;
        int tip = 0;
        command = request.getParameter("command");

        switch (command) {
            case "getBody": {
                id = Integer.parseInt(request.getParameter("id"));
                semestr = Integer.parseInt(request.getParameter("semestr"));
                try {
                    out.print(getBody(id, semestr));
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
                    System.out.println("ClassNotFoundException ex ==> " + ex);
                }
                break;
            }
            case "getGr": {
                System.out.println(request.getParameter("kurs"));
                cource = Integer.parseInt(request.getParameter("kurs"));
                semestr = Integer.parseInt(request.getParameter("semestr"));

                try {
                    out.print(getGr(cource, semestr));
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case "add": {

                id = Integer.parseInt(request.getParameter("id_st"));
                data = request.getParameter("data");
                znach = Integer.parseInt(request.getParameter("znach"));
                tip = Integer.parseInt(request.getParameter("tip"));

                addPosesh(id, data, znach, tip);
                out.print("Success");
                break;
            }
        }

//        System.out.println("id = " + id + " ; semestr = " + semestr);
    }

    private String getBody(int id, int semestr) throws ClassNotFoundException {

        Class.forName("com.mysql.jdbc.Driver");
        StringBuilder sb = new StringBuilder();
        try (Connection con = (Connection) DriverManager.getConnection(URL, USER, PASS);
                CallableStatement proc = con.prepareCall("{call procedure1(" + id + "," + semestr + ")}");) {
            ResultSet rs = proc.executeQuery();
            rs.next();
            int weeks = rs.getInt(1);
            proc.getMoreResults();
            rs = proc.getResultSet();
            while (rs.next()) {
                sb.append("<tr data-id_user='").append(rs.getInt("id")).append("'>"
                        + "<td class='n'>").append(rs.getInt("nomer")).append("</td>")
                        .append("<td class='fio'>").append(rs.getString("FIO")).append("</td>")
                        .append("<td class='tip'>").append(rs.getString("type_name")).append("</td>");
                int i = 1;
                int prop = 0;
                int uv_prop = 0;
                while (i <= weeks) {
                    if (rs.getString("w" + i).length() > 0) {
                        String[] str = rs.getString("w" + i).split(":");
                        String[] str1 = str[0].split("§");
                        sb.append("<td data-p='1' data-id_posesh='")
                                .append(str[1]).append("'>").append(str1[0].equals("0")?"":str1[0])
                                .append("</td><td data-p='2' data-id_posesh='").append(str[1]).append("'>")
                                .append(str1[1].equals("0")?"":str1[1]).append("</td>");

                        prop += Integer.parseInt(str1[0]);
                        uv_prop += Integer.parseInt(str1[1]);
                    } else {
                        sb.append("<td data-p='1'></td><td class='prps' data-p='2'></td>");
                    }
                    i++;
                }
                if ((prop - uv_prop) < 40) {
                    sb.append("<td class='summ prop'>").append(prop).append("</td><td class='summ uv_prop'>").append(uv_prop)
                            .append("</td><td class='summ neUv_prop'><strong>").append(prop - uv_prop).append("</strong></td>");
                } else {
                    sb.append("<td class='summ prop'>").append(prop).append("</td><td class='summ uv_prop'>").append(uv_prop)
                            .append("</td><td class='summ neUv_prop'><strong style = color:red;>").append(prop - uv_prop).append("</strong></td>");
                }
                prop = 0;
                uv_prop = 0;
                sb.append("</tr>");
            }
//            System.out.println("sb ---> " + sb);
        } catch (SQLException ex) {
            System.out.println("SQLException --->>> " + ex);
        }
        return sb.toString();
    }

    private List getGroups(int kurs, int sem) throws ClassNotFoundException {
        System.out.println("kurs " + kurs + " : sem " + sem);
//        String sql = "select id, name, id_faculty from spr_group";
        String sql2 = "SELECT spr_group.id, spr_group.name, spr_group.id_faculty FROM grafik INNER JOIN spr_group ON grafik.id_group = spr_group.id WHERE grafik.kurs = " + kurs
                + " AND semester=" + sem;

        List<SprGroup> list = new ArrayList();
        Class.forName("com.mysql.jdbc.Driver");
        try (Connection con = (Connection) DriverManager.getConnection(URL, USER, PASS);
                PreparedStatement ps = con.prepareStatement(sql2);) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SprGroup s = new SprGroup(rs.getInt(1), rs.getString(2), rs.getInt(3));
                list.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    private List getDaysOfWeeks(Date startNed, int weeks) {
        SimpleDateFormat format = new SimpleDateFormat("dd.MM");
        Calendar c1 = new GregorianCalendar();
        Calendar c2 = new GregorianCalendar();
        c1.setTime(startNed);
        c2.setTime(c1.getTime());
        c2.add(Calendar.DAY_OF_MONTH, 5);

        List<String> days = new ArrayList();
        for (int i = 0; i < weeks; i++) {
            days.add(format.format(c1.getTime()) + "<br>" + format.format(c2.getTime()));
            c1.add(Calendar.DAY_OF_MONTH, 7);
            c2.add(Calendar.DAY_OF_MONTH, 7);
        }
        return days;
    }

    private List getDaysOfWeeksToDB(Date startNed, int weeks) {
        System.out.println("----------------- getDaysOfWeeksToDB --------------------" + startNed + " : " + weeks);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c1 = new GregorianCalendar();
//        Calendar c2 = new GregorianCalendar();
        c1.setTime(startNed);
//        c2.setTime(c1.getTime());
//        c2.add(Calendar.DAY_OF_MONTH, 5);

        List<String> days = new ArrayList();
        for (int i = 0; i < weeks; i++) {
            days.add(format.format(c1.getTime()));
            c1.add(Calendar.DAY_OF_MONTH, 7);
//            c2.add(Calendar.DAY_OF_MONTH, 7);
        }
        
        days.forEach((day) -> {
            System.out.println(day);
        });
        return days;
    }

    private String getGr(int cource, int semestr) throws ClassNotFoundException {
        StringBuilder sb = new StringBuilder();
        List<SprGroup> list = getGroups(cource, semestr);
        for (SprGroup sprGroup : list) {
            sb.append("<li><a href='#' onclick=getStudents('getBody'," + sprGroup.getId() + "," + semestr + "," + cource + ");>" + sprGroup.getName() + "</a></li>"
            );
        }
        return sb.toString();
    }

    private void addPosesh(int id, String data, int znach, int tip) {
        System.out.println("------------- call proc_posesh_add ----------------");
        System.out.println("{call proc_posesh_add(" + id + ",'" + data + "'," + znach + "," + tip + ")}");
        try (Connection con = (Connection) DriverManager.getConnection(URL, USER, PASS);
                CallableStatement proc = con.prepareCall("{call proc_posesh_add(" + id + ",'" + data + "'," + znach + "," + tip + ")}");) {

            proc.execute();
//            int i = 1;
//            while (rs.next()) {
//                int kurs = rs.getInt("kurs");
//                request.setAttribute("kurs" + i, kurs);
//                System.out.println("kurs" + i + " = " + kurs);
//                int weeks = rs.getInt("weeks");
//                request.setAttribute("weeks" + i, weeks);
//                System.out.println("weeks" + i + " = " + weeks);
//
//                Date startNed = rs.getDate("startNed");
//                request.setAttribute("d" + i, getDaysOfWeeks(startNed, weeks));
//                System.out.println("d" + i++ + " = " + getDaysOfWeeks(startNed, weeks));
//                List<SprGroup> sprG = getGroups(1, Integer.parseInt(uch_semstr));
//                request.setAttribute("groups", getGroups(1, Integer.parseInt(uch_semstr)));
////                    for (SprGroup s : sprG) {
////                        System.out.println(s.getId() + " , " + s.getName() + " , " + s.getIdFac());
////                    }
//
////                    i++;
//            }

        } catch (SQLException ex) {
            Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
