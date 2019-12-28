# Kubernetes Prometheus Operator

## Install Prometheus Operator on an existing K8 cluster

Clone the repo and install Prometheus Operator using shell script.

```
git clone https://github.com/mazrc/prometheus-operator.git
cd prometheus-operator
./install.sh <namespace>
```

## Prometheus UI
```
kubectl port-forward svc/prometheus-service -n <namespace> 9090:8080
```
View UI at: http://localhost:9090/

## Cleanup

```
./uninstall.sh <namespace>
```

