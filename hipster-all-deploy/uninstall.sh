# Set namespace to desired name
export NAMESPACE="hipster"

kubectl delete -n ${NAMESPACE} -f ./
kubectl delete namespace ${NAMESPACE}
