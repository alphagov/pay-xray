#!/usr/bin/env bash

RESOURCE_ARN=$(curl -s http://172.17.0.1:51678/v1/metadata | tr "," "\n" | grep ContainerInstanceArn | sed 's/"ContainerInstanceArn"://' | sed 's/"//g')

echo $XRAY_CONFIG | base64 -d > /xray-daemon.yaml
sed -i "s,^ResourceARN.*,ResourceARN: ${RESOURCE_ARN}," /xray-daemon.yaml 

/usr/bin/xray --config /xray-daemon.yaml
