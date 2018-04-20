#!/bin/bash 

# Author: Sufyaan Kazi
# Date: March 2018
# Purpose: Removes the $BE_TAG and $FE_TAG deployments

. vars.properties
. common.sh

echo_mesg "Performing Cleanup if necessary"

gcloud compute firewall-rules delete tf-fw -q > /dev/null 2>&1
gcloud compute compute delete tfinstance --zone=$ZONE -q > /dev/null 2>&1
gcloud compute addresses delete tfstaticip --region=$REGION -q > /dev/null 2>&1

echo_mesg "Cleanup Complete"
