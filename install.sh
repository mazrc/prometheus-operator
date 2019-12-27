#!/bin/bash

if [ $# -lt 1 ]
then
  echo "Usage: $0 <namespace> "
  exit 3
fi

if [ -z $1 ]
then
  echo "Please give namespace as argument - regex : '[a-z0-9]([-a-z0-9]*[a-z0-9])?'"
  exit -1
else
  namespace=$1
fi

echo "creating namespace $namespace"
kubectl create namespace $namespace

echo "applying rbac"
cat configs/rbac.yaml \
  | sed "s/namespace: .*/namespace: $namespace/" \
  | kubectl -n $namespace apply -f -

echo "creating prometheus deployment"
cat configs/deployment.yaml \
  | sed "s/namespace: .*/namespace: $namespace/" \
  | kubectl -n $namespace apply -f -

echo "installing prometheus operator"
cat configs/operator.yaml \
  | sed "s/namespace: .*/namespace: $namespace/" \
  | kubectl -n $namespace apply -f -

echo "applying prometheus configmaps"
cat configs/configmap.yaml \
  | sed "s/namespace: .*/namespace: $namespace/" \
  | kubectl -n $namespace apply -f -

echo "creating prometheus service"
cat configs/service.yaml \
  | sed "s/namespace: .*/namespace: $namespace/" \
  | kubectl -n $namespace apply -f -

echo "list of pods in the namespace: $namespace" 
kubectl get pods -n $namespace

echo "list of services in the namespace: $namespace" 
kubectl get svc -n $namespace