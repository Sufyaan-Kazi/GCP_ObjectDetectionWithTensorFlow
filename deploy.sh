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
gcloud compute addresses create $IP --region=$REGION
ADDRESS=`gcloud compute addresses describe $IP --region=$REGION | grep address: | cut -d ' ' -f2`
gcloud compute addresses list

######### Create the Instance
echo_mesg "Creating TensorFlow Instance"
gcloud compute instances create $INSTANCE --zone=$ZONE --machine-type=$MC_TYPE --tags=$TAG --metadata=serial-port-enable=1 --metadata-from-file=startup-script=startup-script.sh --network-interface=address=$ADDRESS

####### Wait for the instance to start
echo_mesg "Waiting for App to be ready"
waitForInstanceToStart $INSTANCE
checkAppIsReady $ADDRESS

####### Creating Firewall Rule
echo_mesg "Creating Firewall Rule"
gcloud compute firewall-rules create $FW --network=default --allow=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=$TAG
sleep 3

####### Launch
open http://$ADDRESS/
echo "username/passw0rd"
