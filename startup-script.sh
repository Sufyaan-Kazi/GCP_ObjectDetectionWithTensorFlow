#!/bin/bash

sudo -i

# Instal Pre-reqs
apt-get update
apt-get install -y protobuf-compiler python-pil python-lxml python-pip python-dev git
pip install Flask==0.12.2 WTForms==2.1 Flask_WTF==0.14.2 Werkzeug==0.12.2

# Install tensorFlow
pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.1.0-cp27-none-linux_x86_64.whl

# Install Object Detection Library
cd /opt
git clone https://github.com/tensorflow/models
cd models/research
protoc object_detection/protos/*.proto --python_out=.

# Download pre-trained Models
mkdir -p /opt/graph_def
cd /tmp
for model in \
  ssd_mobilenet_v1_coco_11_06_2017 \
  ssd_inception_v2_coco_11_06_2017 \
  rfcn_resnet101_coco_11_06_2017 \
  faster_rcnn_resnet101_coco_11_06_2017 \
  faster_rcnn_inception_resnet_v2_atrous_coco_11_06_2017
do \
  curl -OL http://download.tensorflow.org/models/object_detection/$model.tar.gz
  tar -xzf $model.tar.gz $model/frozen_inference_graph.pb
  cp -a $model /opt/graph_def/
done

# Choose a model
ln -sf /opt/graph_def/faster_rcnn_resnet101_coco_11_06_2017/frozen_inference_graph.pb /opt/graph_def/frozen_inference_graph.pb

# Install a web app
cd $HOME
git clone https://github.com/GoogleCloudPlatform/tensorflow-object-detection-example
cp -a tensorflow-object-detection-example/object_detection_app /opt/
cp /opt/object_detection_app/object-detection.service /etc/systemd/system/
systemctl daemon-reload

# Launch the App
systemctl enable object-detection
systemctl start object-detection
systemctl status object-detection

