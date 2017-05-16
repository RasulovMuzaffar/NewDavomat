/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inst.reports;

import com.mysql.jdbc.Connection;
import inst.Servlet;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Muzaffar
 */
public class Reports extends HttpServlet {

    private static final String URL = "jdbc:mysql://localhost:3306/students";
    private static final String USER = "test";
    private static final String PASS = "test";

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int kurs = 0;
        int sem = 0;
        int h = 0;

        try {
            kurs = Integer.parseInt(request.getParameter("kurs"));
            sem = Integer.parseInt(request.getParameter("sem"));
            h = Integer.parseInt(request.getParameter("h"));
        } catch (Exception e) {
        }
        try {
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection con = (Connection) DriverManager.getConnection(URL, USER, PASS);
                    CallableStatement proc = con.prepareCall("{call report(" + kurs + "," + sem + "," + h + ")}");) {

                ResultSet rs = proc.executeQuery();
                
            } catch (SQLException ex) {
                Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
        }

//    public void aaa08(String param) {
//        System.out.println("------------   aaa08 " + param);
//        try (Connection con_ = DriverManager.getConnection(Singleton.getBASE(), Singleton.getBASE_LOGIN(), Singleton.getBase_password());
//                CallableStatement proc_ = con_.prepareCall("{call report_passport(" + param + ")}");) {
//            proc_.execute();
//            new File(Singleton.getWeb_location() + "reports/" + webSocket_.getName()).mkdir();
//            OutputStream output = new FileOutputStream(new File(Singleton.getWeb_location() + "reports/" + webSocket_.getName() + "/passport1.pdf"));
//            List<JasperPrint> jasperPrintList = new ArrayList<>();
//            JRPdfExporter exporter = new JRPdfExporter();
//            do {
//                rs = proc_.getResultSet();
////rs.next();
//                JasperFillManager.fillReportToFile(Singleton.getWeb_location() + "reports/passport1.jasper", null, new JRResultSetDataSource(rs));
//                jasperPrintList.add((JasperPrint) JRLoader.loadObjectFromFile(Singleton.getWeb_location() + "reports/passport1.jrprint"));
//
//                exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
//                exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(output));
//                SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
//                configuration.setCreatingBatchModeBookmarks(true);
//                exporter.setConfiguration(configuration);
//
//            } while (proc_.getMoreResults());
//            exporter.exportReport();
//
////            webSocket_.send("aaa08|" + webSocket_.getName() + "/passport1.pdf");
//
//        } catch (SQLException | JRException | FileNotFoundException ex) {
//            System.out.println("------------   aaa08  Exception  ");
//            ex.printStackTrace();
//        }
//    }
    }
}
