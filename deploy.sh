#!/bin/bash

export KUBECONFIG=/usr/bin/kubecfg-114
export BUILD_NUMBER=$buildNumber

# # Prepare the service-entries yaml to add the onprem cluster istio ingress gateway IP
# # for all services running in the ${CONTEXT_NAME_2} cluster
# export pattern='.*image:.*'
# export replace="  image: "gcr.io/boarshead-dsi/demo-hipster:$BUILD_NUMBER""
# sed -r -i "s|$pattern|$replace|g" wordpress.yaml
# # sed -i '' "s/${pattern}/${replace}/" wordpress.yaml

#deploy application
kubectl apply -f ./ -n hipster
