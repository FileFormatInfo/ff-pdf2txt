package info.fileformat.pdf2txt;

import java.io.IOException;
import java.io.PrintWriter;

import org.apache.pdfbox.io.RandomAccessReadBuffer;
import org.apache.pdfbox.pdfparser.PDFParser;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.springframework.boot.Banner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.RedirectView;

@RestController
@ServletComponentScan
@SpringBootApplication
public class PdfToTextApp {

    @PostMapping("/convert")
    void postConvert(jakarta.servlet.http.HttpServletResponse resp,
            @RequestParam("file") MultipartFile file) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        if (file.isEmpty()) {
            out.write("ERROR: No file uploaded\n");
            return;
        }
        out.write("INFO: Processing upload\n");
        out.write("INFO: File name: " + file.getOriginalFilename() + "\n");
        out.write("INFO: File size: " + file.getSize() + "\n");
        out.write("INFO: File type: " + file.getContentType() + "\n");
        if (!file.getContentType().equalsIgnoreCase("application/pdf")) {
            out.write("WARNING: File type is not PDF\n");
        }
        out.flush();

        byte[] data = file.getBytes();
        if (data == null || data.length == 0) {
            out.write("ERROR: No data in file\n");
            return;
        }

        // should start with "%PDF"
        if (data[0] != 0x25 || data[1] != 0x50 || data[2] != 0x44 || data[3] != 0x46) {
            out.write("ERROR: File is definitely not a PDF\n");
            return;
        }
        RandomAccessReadBuffer in = new RandomAccessReadBuffer(data);
        PDDocument doc = null;

        try {
            PDFParser parser = new PDFParser(in);
            doc = parser.parse();
        } catch (Exception e) {
            out.println("ERROR: " + e.getMessage() + " (PDFParser.parse)");
            return;
        }

        PDFTextStripper stripper = new PDFTextStripper();
        try {
            stripper.writeText(doc, out);
        } catch (Exception e) {
            out.write("ERROR: " + e.getMessage() + "(PDFTextStripper.writeText)\n");
        }
    }

    @GetMapping("/convert")
    RedirectView getConvert() {
        return new RedirectView("/", false); // 'true' for redirecting also POST requests
    }

    public static void main(String[] args) {
        SpringApplication application = new SpringApplication(PdfToTextApp.class);
        application.setBannerMode(Banner.Mode.OFF);
        application.run(args);
    }
}