# Set vars for DIRs
export HIPSTER_DIR="${PWD}/hipster"
# Set namespace to desired name
export NAMESPACE="hipster"

kubectx ${CONTEXT_NAME_1}
kubectl delete -n ${NAMESPACE} -f ${HIPSTER_DIR}/cloud
kubectl label namespace ${NAMESPACE} istio-injection=enabled --overwrite
kubectl delete namespace ${NAMESPACE}

kubectx ${CONTEXT_NAME_2}
kubectl delete -n ${NAMESPACE}  -f ${HIPSTER_DIR}/onprem
kubectl label namespace ${NAMESPACE} istio-injection=enabled --overwrite
kubectl delete namespace ${NAMESPACE}
