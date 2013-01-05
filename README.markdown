# Extract plain text from a PDF

This is a simple server that extracts text from a PDF using [Apache PDFBox](http://pdfbox.apache.org/).  You can see it in action by looking at the [form at FileFormat.Info](http://www.fileformat.info/convert/doc/pdf2txt.htm).

The code is deliberately simple to avoid dependencies.  All necessary libraries are included.

You will need Jetty installed to run in development.  The included deploy script pushes to [AppFog](https://www.appfog.com/) but should work on any recent Java web server.


## License

Copyright 2013 Andrew Marcuse

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
