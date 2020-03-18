#!/bin/bash
export NAMESPACE=hipster-test
#deploy application
kubectl label namespace ${NAMESPACE}
kubectl apply -f ./ -n ${NAMESPACE}
