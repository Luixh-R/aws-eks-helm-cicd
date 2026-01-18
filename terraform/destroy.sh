#!/bin/bash
set -e

# Configurable variables
AWS_REGION=${AWS_REGION:-us-east-1}
CLUSTER_NAME=${CLUSTER_NAME:-eks-helm-cluster}
NAMESPACE=${NAMESPACE:-default}
HELM_RELEASE=${HELM_RELEASE:-demo-app}
INGRESS_NAME=${INGRESS_NAME:-demo-app}

echo "Setting AWS region to $AWS_REGION"
export AWS_REGION=$AWS_REGION

echo "Retrieving cluster endpoint and updating kubeconfig"
aws eks update-kubeconfig --region $AWS_REGION --name $CLUSTER_NAME

echo "Deleting Kubernetes Ingress and services"
kubectl delete ingress $INGRESS_NAME -n $NAMESPACE || true
kubectl delete svc $HELM_RELEASE -n $NAMESPACE || true

echo "Uninstalling Helm release $HELM_RELEASE"
helm uninstall $HELM_RELEASE -n $NAMESPACE || true

echo "Waiting 2 minutes for ALB ENIs to detach and release resources..."
sleep 120

echo "Destroying Terraform-managed infrastructure"
terraform destroy -auto-approve

