#!/bin/bash 

# Author: Sufyaan Kazi
# Date: April 2018

enableAPIIfNecessary() {
  API_EXISTS=`gcloud services list | grep $1 | wc -l`

  if [ $API_EXISTS -eq 0 ]
  then
    gcloud services enable $1
  fi
}

gcloud config set compute/zone europe-west2-b

enableAPIIfNecessary compute.googleapis.com
enableAPIIfNecessary iam.googleapis.com
enableAPIIfNecessary cloudresourcemanager.googleapis.com
enableAPIIfNecessary language.googleapis.com
enableAPIIfNecessary speech.googleapis.com
enableAPIIfNecessary dataproc.googleapis.com
