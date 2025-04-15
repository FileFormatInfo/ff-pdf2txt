package info.fileformat.pdf2txt;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.Map;

@Controller
public class StatusController {

	@GetMapping("/status.json")
	public void handle(jakarta.servlet.http.HttpServletResponse resp, @RequestParam(required = false) String callback)
			throws IOException {

		// Create a JSON response
		Map<String, Object> retVal = new LinkedHashMap<>();
		retVal.put("success", Boolean.TRUE);
		retVal.put("message", "OK");
		retVal.put("commit", System.getenv("COMMIT"));
		retVal.put("timestamp", ZonedDateTime.now(ZoneOffset.UTC).format(DateTimeFormatter.ISO_INSTANT));
		retVal.put("lastmod", System.getenv("LASTMOD"));
		retVal.put("tech", "Java " + System.getProperty("java.specification.version", "(unknown)"));
		retVal.put("version", System.getProperty("java.version", "Unknown") + " ("
				+ System.getProperty("java.vm.name", "Unknown VM") + ")");
		retVal.put("java.vendor", System.getProperty("java.vendor"));
		retVal.put("java.version", System.getProperty("java.version"));
		retVal.put("java.specification.version", System.getProperty("java.specification.version"));
		retVal.put("java.class.version", System.getProperty("java.class.version"));
		retVal.put("java.vm.version", System.getProperty("java.vm.version"));
		retVal.put("os.name", System.getProperty("os.name"));
		retVal.put("java.vm.specification.version", System.getProperty("java.vm.specification.version"));
		retVal.put("java.vm.vendor", System.getProperty("java.vm.vendor"));
		retVal.put("java.vm.name", System.getProperty("java.vm.name"));
		retVal.put("file.encoding", System.getProperty("file.encoding"));

		HandleJsonp.handleJsonp(resp, callback, retVal);
	}
}
