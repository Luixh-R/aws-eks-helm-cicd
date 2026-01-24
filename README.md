# AWS EKS Terraform Helm Autoscaling Project

This project provisions a production-ready **AWS EKS cluster** using **Terraform**, deploys workloads using **Helm**, and enables **end-to-end autoscaling and observability** with:

* AWS Load Balancer Controller (ALB Ingress)
* Cluster Autoscaler (node-level scaling)
* Horizontal Pod Autoscaler (HPA)
* Prometheus & Grafana (monitoring and metrics)

The setup follows AWS and Kubernetes best practices, including **IRSA (IAM Roles for Service Accounts)** and least-privilege IAM policies.

---

## Architecture Overview

* **AWS EKS** for Kubernetes control plane
* **Managed Node Groups** for worker nodes
* **ALB Ingress Controller** for external traffic
* **Helm** for Kubernetes application lifecycle
* **Cluster Autoscaler** for EC2 Auto Scaling Groups
* **HPA** for pod-level scaling
* **Prometheus + Grafana** for observability

---

## Repository Structure

```
.
├── vpc.tf                          # VPC, subnets, IGW, routing
├── eks-cluster.tf                  # EKS cluster and node groups
├── eks-sa.tf                       # Kubernetes service accounts (IRSA)
├── iam-alb-controller.tf           # IAM for AWS Load Balancer Controller
├── iam-cluster-autoscaler.tf       # IAM for Cluster Autoscaler
├── helm-alb-controller.tf          # AWS Load Balancer Controller (Helm)
├── helm-cluster-autoscaler.tf      # Cluster Autoscaler (Helm)
├── helm-monitoring.tf              # Prometheus & Grafana (Helm)
├── k8s-hpa.tf                      # Horizontal Pod Autoscaler
├── outputs.tf                      # Terraform outputs
├── providers.tf                    # AWS, Kubernetes, Helm providers
├── README.md
```

---

## Prerequisites

* AWS account with permissions for EKS, EC2, IAM
* Terraform >= 1.5
* kubectl
* Helm
* AWS CLI configured (`aws configure`)

---

## Deployment Steps

### 1. Initialize Terraform

```bash
terraform init
```

---

### 2. Create Infrastructure

```bash
terraform apply
```

This will:

* Create the AWSVPC and networking
* Provision the EKS cluster and node groups
* Configure IAM roles and IRSA
* Deploy controllers and monitoring via Helm

---

### 3. Configure kubectl

```bash
aws eks update-kubeconfig \
  --region us-east-1 \
  --name eks-helm-cluster
```

Verify:

```bash
kubectl get nodes
```

---

## Autoscaling

### Cluster Autoscaler (Node Scaling)

* Automatically adds/removes EC2 nodes
* Triggered when pods cannot be scheduled

Verify:

```bash
kubectl get pods -n kube-system | grep autoscaler
```

---

### Horizontal Pod Autoscaler (Pod Scaling)

* Scales pods based on CPU utilization

Verify:

```bash
kubectl get hpa
```

---

## Monitoring

Monitoring stack is deployed in the `monitoring` namespace.

### Access Grafana (Port Forward)

```bash
kubectl port-forward svc/kube-prometheus-stack-grafana -n monitoring 3000:80
```

Open:

* [http://localhost:3000](http://localhost:3000)

(Default credentials are set via Helm values.)

### Access Prometheus

```bash
kubectl port-forward svc/kube-prometheus-stack-prometheus -n monitoring 9090:9090
```

---

## Ingress & Load Balancing

* Uses **AWS Application Load Balancer**
* Managed automatically by AWS Load Balancer Controller

Verify:

```bash
kubectl get ingress
```

---

## Cleanup / Destroy

To avoid dangling AWS resources (ALBs, ENIs), always delete Kubernetes workloads **before** destroying infrastructure.

```bash
terraform destroy
```

---

## Key Best Practices Implemented

* IAM Roles for Service Accounts (IRSA)
* Least-privilege IAM policies
* Helm-managed Kubernetes components
* Separation of infrastructure and workloads
* Safe autoscaling configuration

---

## Notes

* ALB resources may take several minutes to fully delete
* Always ensure Helm releases are removed before `terraform destroy`
* Metrics Server is required for HPA to function

---

## Future Improvements

* Add CI/CD pipeline (GitHub Actions)
* Enable TLS via ACM + Ingress
* Add ArgoCD or Flux
* Multi-environment support (dev/stage/prod)

---

## Author

Provisioned and managed using Terraform, Kubernetes, Helm and AWS best practices.

