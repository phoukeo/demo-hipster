#!/bin/bash
export NAMESPACE=hipster
#deploy application
kubectl create namespace ${NAMESPACE}
kubectl label namespace ${NAMESPACE} istio-injection=enabled --overwrite
kubectl apply -f ./ -n hipster
