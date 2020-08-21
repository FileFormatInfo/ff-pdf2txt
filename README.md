# Extract plain text from a PDF [<img alt="FileFormat.Info logo" src="www/favicon.svg" height="90" align="right" />](https://pdf2txt.fileformat.info/)

This is a simple server that extracts text from a PDF using [Apache PDFBox](http://pdfbox.apache.org/).  

You can try it from the [pdf2txt page on FileFormat.Info](http://www.fileformat.info/convert/doc/pdf2txt.htm).

This is really just a webapp that runs the [org.apache.pdfbox.text.PDFTextStripper](https://pdfbox.apache.org/docs/2.0.13/javadocs/org/apache/pdfbox/text/PDFTextStripper.html) class.

## Running your own copy

The code is deliberately simple to avoid dependencies.  All necessary libraries are included.

The easiest way to run it is with the included super-simple Dockerfile.  See the [run.sh](run.sh) and [docker-run.sh](docker-run.sh) shell scripts to see how I run it in development and production.

The code should work on any recent Java web server.  There is nothing to compile: all the code is in the `.jsp` files.

Environment variables:

- `FORM_URL`: the full URL of a form that should be used instead of the form in index.jsp.  This will also trigger logging if it doesn't match the referrer.

## License

[GNU Affero General Public License v3.0](LICENSE.txt)

## Credits

[![Apache PDFBox](https://www.vectorlogo.zone/logos/apache/apache-ar21.svg)](https://pdfbox.apache.org/ "PDF processing")
[![Docker](https://www.vectorlogo.zone/logos/docker/docker-ar21.svg)](https://www.docker.com/ "Containers")
[![Git](https://www.vectorlogo.zone/logos/git-scm/git-scm-ar21.svg)](https://git-scm.com/ "Version control")
[![Github/GithubActions](https://www.vectorlogo.zone/logos/github/github-ar21.svg)](https://github.com/ "Code hosting and Continuous Integration")
[![GoatCounter](https://www.vectorlogo.zone/logos/goatcounter/goatcounter-ar21.svg)](https://www.goatcounter.com/ "Traffic Measurement")
[![Google Cloud Run](https://www.vectorlogo.zone/logos/google_cloud_run/google_cloud_run-ar21.svg)](https://cloud.google.com/run/ "Hosting")
[![Java](https://www.vectorlogo.zone/logos/java/java-ar21.svg)](https://www.java.com/ "Programming Language")
[![Jetty](https://www.vectorlogo.zone/logos/eclipse_jetty/eclipse_jetty-ar21.svg)](https://www.eclipse.org/jetty/ "Web server")
[![water.css](https://www.vectorlogo.zone/logos/netlifyapp_watercss/netlifyapp_watercss-ar21.svg)](https://watercss.netlify.app/ "Classless CSS")

* [Apache Commons](https://commons.apache.org/)
* [bouncycastle](https://www.bouncycastle.org/)
* [JSON Simple](https://github.com/fangyidong/json-simple)