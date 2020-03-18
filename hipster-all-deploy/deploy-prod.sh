#!/bin/bash
export NAMESPACE=hipster-prod
#deploy application
kubectl apply -f ./ -n ${NAMESPACE}
