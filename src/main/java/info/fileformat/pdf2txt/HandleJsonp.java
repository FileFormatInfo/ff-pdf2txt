package info.fileformat.pdf2txt;

import java.io.PrintWriter;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;

public class HandleJsonp {

	public static void handleJsonp(
			jakarta.servlet.http.HttpServletResponse resp,
			String callback,
			Map<String, Object> retVal
		) throws java.io.IOException {

		ObjectMapper objectMapper = new ObjectMapper();
		String jsonResponse = objectMapper.writeValueAsString(retVal);

		if (callback != null && callback.matches("^[a-zA-Z_][a-zA-Z0-9_]*$")) {
			resp.setContentType("application/javascript");
			resp.setCharacterEncoding("UTF-8");
			PrintWriter writer = resp.getWriter();
			writer.write(callback);
			writer.write("(");
			writer.write(jsonResponse);
			writer.write(");");
		} else {
			resp.setHeader("Access-Control-Allow-Origin", "*");
			resp.setHeader("Access-Control-Allow-Methods", "GET, POST");
			resp.setHeader("Access-Control-Max-Age", "604800");
			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			resp.getWriter().write(jsonResponse);
		}
	}
}
