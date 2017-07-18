#!/bin/bash
#
# deploy to Google AppEngine
#
gcloud beta app deploy --project=ff-pdf2txt --verbosity=info www
