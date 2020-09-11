#!/bin/bash

unset KUBECONFIG

. ./env

echo "Logging into Openshift"
oc login $OPENSHIFT_API_URL \
    --username=$OPENSHIFT_USERNAME \
    --password=$OPENSHIFT_PASSWORD \
    --insecure-skip-tls-verify=true

echo "Logging into Openshift image registry"
podman login \
    --username $OPENSHIFT_USERNAME \
    --password $(oc whoami -t) \
    --tls-verify=false \
    $OPENSHIFT_REGISTRY_URL

echo "Switch to $OPENSHIFT_PROJECT"
oc project $OPENSHIFT_PROJECT

echo "Building the container image"
buildah build-using-dockerfile \
  -t ${OPENSHIFT_REGISTRY_URL}/$OPENSHIFT_PROJECT/app-modernization:v1.0.0 \
    .
    
echo "Pushing the container image to the Openshift image registrry"
podman push --tls-verify=false \
  ${OPENSHIFT_REGISTRY_URL}/${OPENSHIFT_PROJECT}/app-modernization:v1.0.0
