#!/bin/bash

unset KUBECONFIG

. ./env

echo "Logging into Openshift"
oc login $OPENSHIFT_API_URL \
    --username=$OPENSHIFT_USERNAME \
    --password=$OPENSHIFT_PASSWORD \
    --insecure-skip-tls-verify=true

echo "Creating Openliberty Custom Resource Definition"
oc -n $OPENSHIFT_PROJECT create -f app-mod-withroute_cr.yaml
