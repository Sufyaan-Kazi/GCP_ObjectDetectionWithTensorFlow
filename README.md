https://twitter.com/Sufyaan_Kazi

# GCP_ObjectDetectionWithTensorFlow
Run this by executing 'deploy.sh' in cloudshell in empty GCP project (or from OSX Terminal with gcloud installed). This is an automated version of a public GCP Training course for TensorFlow: https://cloud.google.com/solutions/creating-object-detection-application-tensorflow. This uses the http://mscoco.org/ data set. 

It launches a Google Compute Instance running an open source Object Detection API running atop of Tensorflow and a web app. The web app allows you to upload an image and will demonstrate tensorflow using different data sets to detect objects in the image.

To change the object detection library (for speed and/or different acuracy), modify the matching line in startup-script.sh using the instructions here: https://cloud.google.com/solutions/creating-object-detection-application-tensorflow#change_the_inference_model

