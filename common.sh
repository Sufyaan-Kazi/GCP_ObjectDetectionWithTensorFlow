#!/bin/bash 

echo_mesg() {
   echo "  ----- $1 ----  "
}

###
# Utility method to ensure a URL returns HTTP 200
#
# When a HTTP load balancer is defined, there is a period of time needed to ensure all netowrk paths are clear
# and the requests result in happy requests.
###
checkAppIsReady() {
  #Check app is ready
  local URL=$1
  local HTTP_CODE=$(curl -Is http://${URL}/ | grep HTTP | cut -d ' ' -f2)
  while [ $HTTP_CODE -ne 200 ]
  do
    echo "Waiting for app to become ready: $HTTP_CODE"
    sleep 10
    HTTP_CODE=$(curl -Is http://${URL}/ | grep HTTP | cut -d ' ' -f2)
  done
}
