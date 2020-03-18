#!/bin/bash
export NAMESPACE=hipster
#deploy application
kubectl apply -f ./ -n ${NAMESPACE}
