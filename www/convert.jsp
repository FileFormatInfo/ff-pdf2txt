<%@ page contentType="text/plain;charset=utf-8"
		 errorPage="/500.jsp"
		 import="java.io.*,
		 		 java.text.*,
		 		 java.util.*,
		 		 java.util.logging.Logger,
		 		 java.util.regex.*,
		 		 org.apache.commons.fileupload.*,
		 		 org.apache.commons.fileupload.servlet.*,
		 		 org.apache.commons.fileupload.util.*,
		 		 org.apache.commons.lang3.*,
		 		 org.apache.pdfbox.exceptions.InvalidPasswordException,
		 		 org.apache.pdfbox.pdfparser.PDFParser,
		 		 org.apache.pdfbox.pdmodel.PDDocument,
		 		 org.apache.pdfbox.util.PDFTextStripper"
%><%!
    private static final Logger log = Logger.getLogger("convert.jsp");
    private static final Pattern refpat = Pattern.compile("^https?://www\\.fileformat\\.info/.*");
%><%

	if (request.getMethod().equalsIgnoreCase("post") == false)
	{
		response.sendRedirect("https://www.fileformat.info/convert/doc/pdf2txt.htm");
		return;
	}
	
	String referrer = request.getHeader("Referer");
	if (referrer == null)
	{
	    log.info("No referrer");
	}
	else if (refpat.matcher(referrer).matches() == false)
	{
	    log.warning("Foreign referrer: '" + referrer + "'");
    }

	Map<String, String> params = new HashMap<String, String>();
	byte[] data = null;
	byte[] result = null;

	ServletFileUpload upload = new ServletFileUpload();

	try
	{
		FileItemIterator iterator = upload.getItemIterator(request);
		while (iterator.hasNext())
		{
			FileItemStream item = iterator.next();
			InputStream stream = item.openStream();

			if (item.isFormField())
			{
				String value = Streams.asString(stream);
				params.put(item.getFieldName(), value);
			}
			else
			{
				int total = 0;
				int len;
				byte[] buffer = new byte[8192];
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				while ((len = stream.read(buffer, 0, buffer.length)) != -1)
				{
					total += len;
					baos.write(buffer, 0, len);
				}
				data = baos.toByteArray();
			}
		}
	}
	catch (Exception e)
	{
		log.severe("Upload error: " + e.getMessage());
		out.println("ERROR: unable to process request (" + e.getMessage() + ")");
		return;
	}

	if (data == null || data.length == 0)
	{
	    log.severe("No file uploaded");
		out.println("ERROR: No file uploaded");
		return;
	}

	InputStream in = new ByteArrayInputStream(data);
	PDDocument doc = null;

	try
	{
		PDFParser parser = new PDFParser( in );
		parser.parse();
		doc = parser.getPDDocument();
	}
	catch (Exception e)
	{
	    log.severe("Parse error: " + e.getMessage());
		out.println("ERROR: " + e.getMessage() + " (PDFParser.parse)");
		return;
	}

	PDFTextStripper stripper = new PDFTextStripper();
	try
	{
		stripper.writeText( doc, out );
	}
	catch (Exception e)
	{
	    log.severe("Write error: " + e.getMessage());
		out.println("ERROR: " + e.getMessage() + " (PDFTextStripper.writeText)");
		return;
	}
%>
