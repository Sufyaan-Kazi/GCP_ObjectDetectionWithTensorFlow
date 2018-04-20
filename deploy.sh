#!/bin/bash 

# Author: Sufyaan Kazi
# Date: April 2018
# Purpose: Creates a Compute Instance to run a web app which uses TensorFlow to detect objects

#Load in vars and common functions
. ./vars.properties
. ./common.sh

# Start
. ./cleanup.sh

######## Create Static IP
echo_mesg "Allocating Static IP"
gcloud compute addresses create tfstaticip --region=$REGION
ADDRESS=`gcloud compute addresses describe tfstaticip --region=europe-west2 | grep address: | cut -d ' ' -f2`
gcloud compute addresses list

######### Create the Instance
echo_mesg "Creating TensorFlow Instance"
gcloud compute instances create tfinstance --zone=$ZONE --machine-type=custom-4-8192 --tags=http-service --metadata=serial-port-enable=1 --metadata-from-file=startup-script=startup-script.sh --network-interface=address=$ADDRESS

####### Wait for the instance to start
checkAppIsReady $ADDRESS
gcloud compute instances get-serial-port-output tfinstance --zone=europe-west2-b

####### Creating Firewall Rule
echo_mesg "Creating Firewall Rule"
gcloud compute firewall-rules create tf-fw --network=default --allow=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=imageapp
