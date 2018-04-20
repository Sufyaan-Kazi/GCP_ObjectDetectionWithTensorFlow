#!/bin/bash 

# Author: Sufyaan Kazi
# Date: March 2018
# Purpose: Removes the $BE_TAG and $FE_TAG deployments

. vars.properties
. common.sh

echo_mesg "Performing Cleanup if necessary"

gcloud compute firewall-rules delete $FW -q > /dev/null 2>&1
gcloud compute instances delete $INSTANCE --zone=$ZONE -q > /dev/null 2>&1
gcloud compute addresses delete $IP --region=$REGION -q > /dev/null 2>&1

echo_mesg "Cleanup Complete"
