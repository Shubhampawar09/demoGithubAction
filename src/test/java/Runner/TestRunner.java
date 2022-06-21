package Runner;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;
import org.yaml.snakeyaml.Yaml;

import java.io.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import static junit.framework.Assert.assertTrue;

public class TestRunner {

static String karateOutputPath = "target/integration-tests";

    @Test
    public void testParallel() {
        String tags = System.getProperty("tags");
        String[] paths = "classpath:features".split(",");

        Results results = Runner
                .path(paths).tags(tags,"@regression")
                .parallel(5);
        generateReport(results.getReportDir());
//        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
    }


//
//        @Test
//    public void testParallel() throws FileNotFoundException {
//        String tags = System.getProperty("tags");
//        String[] paths = "classpath:features".split(",");
//
//        Results results = Runner
//                .path(paths)
//                .parallel(5);
//        generateReport(results.getReportDir());
////        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
//    }





//    @Test
//    void testParallel() throws IOException {
//        Results results = Runner.path("classpath:features").parallel(5);
//        // assertEquals(0, results.getFailCount(), results.getErrorMessages());
//        generateReport(results.getReportDir());


//        java.awt.Desktop.getDesktop()
//                .browse(new java.io.File(System.getProperty("user.dir") + "/target/karate-reports/karate-summary.html")
//                        .toURI());
//    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "demo project");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

}
