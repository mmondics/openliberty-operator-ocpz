#!/bin/bash

unset KUBECONFIG

. ./env

echo "Logging into OpenShift"
oc login $OPENSHIFT_API_URL \
    --username=$OPENSHIFT_USERNAME \
    --password=$OPENSHIFT_PASSWORD \
    --insecure-skip-tls-verify=true

echo "Logging into OpenShift image registry"
podman login \
  --username $OPENSHIFT_USERNAME \
  --password $(oc whoami -t) \
  --tls-verify=false \
  $OPENSHIFT_REGISTRY_URL

echo "Deleting Openliberty app"
oc -n $OPENSHIFT_PROJECT delete OpenLibertyApplication appmod

echo "Deleting imagestream"
oc delete is/app-modernization

sleep 5


