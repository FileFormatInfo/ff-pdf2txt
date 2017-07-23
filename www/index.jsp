<%@ page contentType="text/html;charset=utf-8"
		 errorPage="/500.jsp"
		 import="java.io.*,
		 		 java.text.*,
		 		 java.util.*"
%><%

    if (System.getProperty("com.google.appengine.runtime.environment", "Unknown").equalsIgnoreCase("Production"))
    {
    	response.sendRedirect("https://www.fileformat.info/convert/doc/pdf2txt.htm");
		return;
	}
%><html>
<head>
<title>pdf2txt</title>
</head>
<body>
<form action="convert.jsp"	enctype="multipart/form-data" method="post" name="theForm">
<table class="dataentry">
	<tr>
		<th colspan="2">Extract Text from PDF</th>
	</tr>
	<tr>
		<td valign="top">Source file</td>
		<td><input name="stdin" type="file" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>
			<input type="submit" name="save" value="Submit"/>
			<input type="submit" name="cancel" value="Cancel" />
		</td>
	</tr>
</table>
</form>
</body>
</html>
