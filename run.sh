#!/bin/bash
#
# run the app in a local docker container
#

set -o errexit
set -o pipefail
set -o nounset

echo "INFO: starting"

docker run \
	--publish 4000:8080 \
	--volume /tmp/jetty \
	--volume /run/jetty \
	--volume "${PWD}/www:/var/lib/jetty/webapps/ROOT" \
	jetty:9.4.30-jdk14
