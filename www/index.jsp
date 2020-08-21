<%@ page contentType="text/html;charset=utf-8"
		 errorPage="/500.jsp"
		 import="java.io.*,
		 		 java.text.*,
		 		 java.util.*"
%><%

	String formUrl = System.getenv("FORM_URL");

%><html>
	<head>
		<title>pdf2txt</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="/css/light.css" />
	</head>
	<body>
		<h1>
			<a href="https://www.fileformat.info/"><img alt="FileFormat.Info logo" src="favicon.svg" style="height:2.2em;vertical-align:middle;" /></a>
			pdf2txt
		</h1>
		<p>
			Extract text from a PDF
		</p>
	<% if (formUrl != null && formUrl.length() > 0) { %>
		<p>
			<a href="<%=formUrl%>">Try it!</a>
		</p>
	<% } else { %>
		<form action="convert.jsp" enctype="multipart/form-data" method="post">
			<fieldset>
				<legend>Upload</legend>
				<label for="stdin">PDF file</label>
				<input name="stdin" type="file" />
				<input type="submit" name="save" value="Extract text"/>
			</fieldset>
		</form>
	<% } %>
		<p>
			<a href="https://github.com/FileFormatInfo/ff-pdf2txt">How this works</a>, including source code!
		</p>
		<p>
			<a href="https://www.fileformat.info/">FileFormat.Info</a> has more 
			<a href="https://www.fileformat.info/convert/">file conversion utilities</a>
			and documentation on different <a href="https://www.fileformat.info/format/">file formats</a>.
		</p>
		<footer style="text-align:center">
			<a href="https://www.fileformat.info/about/privacy.htm">Privacy Policy</a>
			| <a href="https://www.fileformat.info/about/tos.htm">Terms of Service</a>
			<img src="https://fileformat.goatcounter.com/count?p=/subsite/pdf2txt/index.html">
		</footer>
	</body>
</html>
