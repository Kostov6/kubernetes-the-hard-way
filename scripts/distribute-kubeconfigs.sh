#!/bin/bash
set -eu

components_prefix=$1
cd kubeconfigs
for instance in ${components_prefix}-worker-0 ${components_prefix}-worker-1 ${components_prefix}-worker-2; do
  gcloud compute scp ${instance}.kubeconfig kube-proxy.kubeconfig ${instance}:~/
done

for instance in ${components_prefix}-controller-0 ${components_prefix}-controller-1 ${components_prefix}-controller-2; do
  gcloud compute scp admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig ${instance}:~/
done
