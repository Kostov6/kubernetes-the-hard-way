#!/bin/bash
set -eu

cd certificates
components_prefix=$1
for instance in "${components_prefix}-worker-0" "${components_prefix}-worker-1" "${components_prefix}-worker-2"; do
  gcloud compute scp ca.pem ${instance}-key.pem ${instance}.pem ${instance}:~/
done

for instance in "${components_prefix}-controller-0" "${components_prefix}-controller-1" "${components_prefix}-controller-2"; do
  gcloud compute scp ca.pem ca-key.pem kubernetes-key.pem kubernetes.pem \
    service-account-key.pem service-account.pem ${instance}:~/
done
