<%@ page contentType="text/plain;charset=utf-8"
		 errorPage="/500.jsp"
		 import="java.io.*,
		 		 java.text.*,
		 		 java.util.*,
		 		 org.apache.commons.fileupload.*,
		 		 org.apache.commons.fileupload.servlet.*,
		 		 org.apache.commons.fileupload.util.*,
		 		 org.apache.commons.lang3.*,
		 		 org.apache.pdfbox.exceptions.InvalidPasswordException,
		 		 org.apache.pdfbox.pdfparser.PDFParser,
		 		 org.apache.pdfbox.pdmodel.PDDocument,
		 		 org.apache.pdfbox.util.PDFTextStripper
"
%><%

	/*if (request.getMethod().equalsIgnoreCase("post") == false)
	{
		response.sendRedirect("http://www.fileformat.info/convert/doc/pdf2txt.htm");
		return;
	}*/

%><%
	Map<String, String> params = new HashMap<String, String>();
	byte[] data = null;
	byte[] result = null;

	ServletFileUpload upload = new ServletFileUpload();

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

	if (data == null || data.length == 0)
	{
		throw new Exception("No file uploaded");
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
		out.println("ERROR: " + e.getMessage() + " (parse)");
		return;
	}

	//response.reset();
	//response.setContentType("text/plain;charset=utf-8");

	try
	{
		PDFTextStripper stripper = new PDFTextStripper();
		stripper.writeText( doc, out );
	}
	catch (Exception e)
	{
		out.write("ERROR: " + e.getMessage() + " (writeText)");
	}

	if (1 == 1)
	{
		return;
	}

%>
