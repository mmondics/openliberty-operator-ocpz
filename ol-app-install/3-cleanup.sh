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

echo "Deleting Openliberty app"
oc -n $OPENSHIFT_PROJECT delete OpenLibertyApplication appmod

sleep 5


