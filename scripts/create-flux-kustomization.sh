#!/bin/bash

SERVICE_NAME=$1

if [ -z "$SERVICE_NAME" ]; then
  echo "Usage: ./create-flux-kustomization.sh <service-name>"
  exit 1
fi

# Create Flux Kustomization
flux create kustomization $SERVICE_NAME \
  --source=GitRepository/gitops-manifests \
  --path="./apps/$SERVICE_NAME" \
  --prune=true \
  --interval=1m \
  --export > flux/apps/$SERVICE_NAME.yaml

echo "Created flux/apps/$SERVICE_NAME.yaml"
echo ""
echo "Apply with:"
echo "  kubectl apply -f flux/apps/$SERVICE_NAME.yaml"
echo ""
echo "Or commit to Git and Flux will apply automatically"
