#!/bin/bash
set -eu

components_prefix=$1

ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)

cat > encryption-config.yaml <<EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF

for instance in ${components_prefix}-controller-0 ${components_prefix}-controller-1 ${components_prefix}-controller-2; do
  gcloud compute scp encryption-config.yaml ${instance}:~/
done
