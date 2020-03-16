#!/usr/bin/env bash

# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

echo "### "
echo "### Deploying hipster app on Cloud and OnPrem clusters"
echo "### "

# Set vars for DIRs
export HIPSTER_DIR="${PWD}/hipster"
# Set namespace to desired name
export NAMESPACE="hipster"

# Get Istio ingress gateway Ip addresses from both cloud and onprem clusters
export GWIP_CLOUD=$(kubectl --context ${CONTEXT_NAME_1} get -n istio-system service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export GWIP_ONPREM=$(kubectl --context ${CONTEXT_NAME_2} get -n istio-system service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

# Prepare cloud cluster hipster manifests
# change context to ${CONTEXT_NAME_1} cluster
kubectx ${CONTEXT_NAME_1}
# Prepare the service-entries yaml to add the onprem cluster istio ingress gateway IP
# for all services running in the ${CONTEXT_NAME_2} cluster
export pattern='.*- address:.*'
export replace="  - address: "$GWIP_ONPREM""
# sed -r -i "s|$pattern|$replace|g" ${HIPSTER_DIR}/cloud/service-entries.yaml
sed -i '' "s/${pattern}/${replace}/" ${HIPSTER_DIR}/cloud/service-entries.yaml

echo "### "
echo "### Deploying hipster app on ${CONTEXT_NAME_1} cluster"
echo "### "

# Create ${NAMESPACE} namespace and enable istioInjection on the namespace
kubectl create namespace ${NAMESPACE}
kubectl label namespace ${NAMESPACE} istio-injection=enabled

# Deploy part of hipster app on ${CONTEXT_NAME_1} cluster in the namespace ${NAMESPACE}
kubectl apply -n ${NAMESPACE}  -f ${HIPSTER_DIR}/cloud

# Prepare onprem cluster hipster manifests
# change context to ${CONTEXT_NAME_2} cluster
kubectx ${CONTEXT_NAME_2}
# Prepare the service-entries yaml to add the onprem cluster istio ingress gateway IP
# for all services running in the ${CONTEXT_NAME_2} cluster
export pattern='.*- address:.*'
export replace="  - address: "$GWIP_CLOUD""
# sed -r -i "s|$pattern|$replace|g" ${HIPSTER_DIR}/onprem/service-entries.yaml
sed -i '' "s/${pattern}/${replace}/" ${HIPSTER_DIR}/onprem/service-entries.yaml

echo "### "
echo "### Deploying hipster app on onprem cluster"
echo "### "

# Create ${NAMESPACE} namespace and enable istioInjection on the namespace
kubectl create namespace ${NAMESPACE}
kubectl label namespace ${NAMESPACE} istio-injection=enabled

# Deploy part of hipster app on ${CONTEXT_NAME_2} cluster in the namespace ${NAMESPACE}
kubectl apply -n ${NAMESPACE}  -f ${HIPSTER_DIR}/onprem
