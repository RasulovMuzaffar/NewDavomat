/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inst.reports;

/**
 *
 * @author Muzaffar
 */
public class Reports {

    public void aaa08(String param) {
        System.out.println("------------   aaa08 " + param);
        try (Connection con_ = DriverManager.getConnection(Singleton.getBASE(), Singleton.getBASE_LOGIN(), Singleton.getBase_password());
                CallableStatement proc_ = con_.prepareCall("{call report_passport(" + param + ")}");) {
            proc_.execute();
            new File(Singleton.getWeb_location() + "reports/" + webSocket_.getName()).mkdir();
            OutputStream output = new FileOutputStream(new File(Singleton.getWeb_location() + "reports/" + webSocket_.getName() + "/passport1.pdf"));
            List<JasperPrint> jasperPrintList = new ArrayList<>();
            JRPdfExporter exporter = new JRPdfExporter();
            do {
                rs = proc_.getResultSet();
//rs.next();
                JasperFillManager.fillReportToFile(Singleton.getWeb_location() + "reports/passport1.jasper", null, new JRResultSetDataSource(rs));
                jasperPrintList.add((JasperPrint) JRLoader.loadObjectFromFile(Singleton.getWeb_location() + "reports/passport1.jrprint"));

                exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
                exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(output));
                SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
                configuration.setCreatingBatchModeBookmarks(true);
                exporter.setConfiguration(configuration);

            } while (proc_.getMoreResults());
            exporter.exportReport();

//            webSocket_.send("aaa08|" + webSocket_.getName() + "/passport1.pdf");

        } catch (SQLException | JRException | FileNotFoundException ex) {
            System.out.println("------------   aaa08  Exception  ");
            ex.printStackTrace();
        }
    }
}
