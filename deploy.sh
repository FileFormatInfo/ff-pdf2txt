#!/bin/bash
#
# deploy to Google AppEngine
#
xmlstarlet edit --inplace --update "//_:property[@name='COMMIT']/@value" -v $(git rev-parse --short HEAD) www/WEB-INF/appengine-web.xml
xmlstarlet edit --inplace --update "//_:property[@name='LASTMOD']/@value" -v $(date -u +%Y-%m-%dT%H:%M:%SZ) www/WEB-INF/appengine-web.xml

gcloud beta app deploy --project=ff-pdf2txt --verbosity=info www

xmlstarlet edit --inplace --update "//_:property[@name='COMMIT']/@value" -v dev www/WEB-INF/appengine-web.xml
xmlstarlet edit --inplace --update "//_:property[@name='LASTMOD']/@value" -v dev www/WEB-INF/appengine-web.xml
