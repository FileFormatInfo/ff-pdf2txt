package info.fileformat.pdf2txt;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.util.UrlPathHelper;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.regex.Pattern;

@Controller
public class CustomErrorController implements ErrorController {

	static final Pattern callbackPattern = Pattern.compile("([&]|^)callback=([^&]+)");

	@RequestMapping("/error")
	public void handleError(jakarta.servlet.http.HttpServletRequest req,
			jakarta.servlet.http.HttpServletResponse resp) throws java.io.IOException {
		Object status = req.getAttribute("jakarta.servlet.error.status_code");


		String callback = null;
		String qs = UrlPathHelper.defaultInstance.getOriginatingQueryString(req);
		if (qs != null) {
			java.util.regex.Matcher matcher = callbackPattern.matcher(qs);
			if (matcher.find()) {
				callback = matcher.group(2);
			}
		}

		Integer statusCode = 500;
		if (status != null) {
			statusCode = Integer.valueOf(status.toString());
		} else {
			// LATER: warning message
			//System.out.println("No status code found in request");
		}

		String message = (String) req.getAttribute("jakarta.servlet.error.message");
		if (message == null || message.length() == 0) {
			//System.out.println("No error message found in request");

			Object ex = req.getAttribute("jakarta.servlet.error.exception");
			if (ex != null && ex instanceof Throwable) {
				Throwable throwable = (Throwable) ex;
				message = throwable.getMessage();
			} else {
				message = "Server Error";
			}
		}
		resp.setStatus(statusCode);
		Map<String, Object> retVal = new LinkedHashMap<>();
		retVal.put("success", Boolean.FALSE);
		retVal.put("code", statusCode);
		retVal.put("message", message);

		HandleJsonp.handleJsonp(resp, callback, retVal);
	}

	public String getErrorPath() {
		return "/error";
	}
}
