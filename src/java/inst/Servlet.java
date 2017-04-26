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
import java.util.ArrayList;
import java.util.Calendar;
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
response.setCharacterEncoding("cp1251");
            PrintWriter out = response.getWriter();

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
            try (Connection con = (Connection) DriverManager.getConnection(URL, USER, PASS);
                    CallableStatement proc = con.prepareCall("{call procedure1(" + 1 + "," + Integer.parseInt(uch_semstr) + ")}");) {
                ResultSet rs = proc.executeQuery();
                rs.next();
                int weeks = rs.getInt(1);
//                Date startNed = rs.getDate(2);
//                System.out.println("startNed ====>>> " + rs.getDate(1));
                request.setAttribute("weeks", weeks);
                request.setAttribute("groups", getGroups(1));

                request.getRequestDispatcher("newjsp.jsp").forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType(CONTENT_TYPE);
        PrintWriter out = response.getWriter();
        String command;
        int id = 0;
        int semestr = 0;
        command = request.getParameter("command");

        switch (command) {
            case "getSum":
//                out.print(getSum(id, name));
                out.print("<tr><td>" + id + "</td><td>" + semestr + "</td></tr>");
                break;
            case "getMin":
                System.out.println("Метод getMin!!!");
                out.print("<tr><td>" + semestr + "</td><td>" + id + "</td></tr>");
                break;
            case "getBody": {
                id = Integer.parseInt(request.getParameter("id"));
                semestr = Integer.parseInt(request.getParameter("semestr"));
                try {
                    out.print(getBody(id, semestr));
                } catch (ClassNotFoundException ex) {
//                    Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
                    System.out.println("ClassNotFoundException ex ==> " + ex);
                }
            }
        }

        System.out.println("id = " + id + " ; semestr = " + semestr);
    }

    private String getSum(int id, String name) {
//        out.print(id + name);
        return id + name;
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
                        + "<td>").append(rs.getInt("nomer")).append("</td>")
                        .append("<td>").append(rs.getString("FIO")).append("</td>")
                        .append("<td>").append(rs.getString("type_name")).append("</td>");
                int i = 1;
                int prop = 0;
                int uv_prop = 0;
                while (i <= weeks) {
                    if (rs.getString("w" + i).length() > 0) {
                        String[] str = rs.getString("w" + i).split(":");
                        String[] str1 = str[0].split("§");
                        sb.append("<td data-p='1' data-id_posesh='").append(str[1]).append("'>").append(str1[0])
                                .append("</td><td data-p='2' data-id_posesh='").append(str[1]).append("'>").append(str1[1]).append("</td>");

                        prop += Integer.parseInt(str1[0]);
                        uv_prop += Integer.parseInt(str1[1]);
                    } else {
                        sb.append("<td data-p='1'></td><td data-p='2'></td>");
                    }
                    i++;
                }
                if ((prop - uv_prop) < 40) {
                    sb.append("<td>").append(prop).append("</td><td>").append(uv_prop)
                            .append("</td><td><strong>").append(prop - uv_prop).append("</strong></td>");
                } else {
                    sb.append("<td>").append(prop).append("</td><td>").append(uv_prop)
                            .append("</td><td><strong style = color:red;>").append(prop - uv_prop).append("</strong></td>");
                }
                prop = 0;
                uv_prop = 0;
                sb.append("</tr>");
            }
            System.out.println("sb ---> " + sb);
        } catch (SQLException ex) {
            System.out.println("SQLException --->>> " + ex);
        }
        return sb.toString();
    }

    private List getGroups(int i) throws ClassNotFoundException {
        String sql = "select id, name, id_faculty from spr_group";
        List<SprGroup> list = new ArrayList();
        Class.forName("com.mysql.jdbc.Driver");
        try (Connection con = (Connection) DriverManager.getConnection(URL, USER, PASS);
                PreparedStatement ps = con.prepareStatement(sql);) {
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
}
