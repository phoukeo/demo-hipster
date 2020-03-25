#!/bin/bash
export NAMESPACE=hipster
#deploy application
kubectl create namespace ${NAMESPACE}
kubectl apply -f ./ -n ${NAMESPACE}
