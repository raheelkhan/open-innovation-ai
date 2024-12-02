# Technical Challenge for Open Innovation AI

This repository contains sample configurations to provision infastructure and deploy application on Kubernetes

## Design Decisions

1. AWS VPC is created with public and private subnets. Public subnet will mainly hosts Applicaiton Load Balancer and private subnet will contain the worker nodes. Things like NAT and IGW are also configrued.

2. Multi region EKS cluster where primary is eu-west-1 and failover region is us-east-1. The idea is that the secondary region will host a minimal capacity nodes and other resources and it can serve as a cold standby to balance the RPO/RTO and cost concerns.

3. I used Postgres on RDS for simplicity reasons. There is a read replica created in us-east-1 which can be quicky used incase of primary region failure. I am aware that same can be created in Cloud Native way in Kubernetes itself but here I kept is simple.

4. There is Global Accelator configured which routes 100% of traffic to eu-west-1 and only routes to us-east-1 if the main region is failing health checks. 

5. There is also Route53 configured which is aliased to Global Accelator so that there is no issue related to DNS cache. The Route53 always points to Global Accelator and Global Accelator will make the decision to route in correct region.

## Kubernetes Cluster Components

1. The AWS Load Balancer Controller is configured to react on Ingress resources. This is mainly for Frontend applicaiton. 

2. ArgoCD operator is configured but actual manifests are missing from this code. 

3. Prometheus free version is installed but no actual configurations applied in this code.

4. Cluster Autoscaler is installed no actual configurations applied in this code.

5. The purpose of above addons is to demonstrate the high level objectives such as HA, Monitoring and GitOps.

## Kubernetes Workload Components

1. The Pods are configured with Resource Requests / Limits.

2. The HPA is configured

3. Ingress is created for frontend application 

4. Network policy is also configured for backend application which only allows ingress only frontend application.

5. Security context is set for the pods to restict access to root user and allow only readonly file system.

6. Frontend pods will only be placed on CPU based nodes where as Backend pods will be placed on GPU based nodes (To assume that backend application does some intensive work)

7. Application logs will be written to stdout / stderr but things like Container Insights or Fluentbit can be configured to push those logs to the aggregator (This code does not include these components)

8. The Secrets are not part of Kubernetes Manifest. Secrets will be in AWS Secrets Manager and basically the Service Account has access to them via IAM Role for Service Accounts.

## Terragrunt / Terraform

This repo is based on a scalable structure which can provision resource on regions / accounts in any order. Some resources such as GA, Route53 and Storage is part for global directory. I have not put code for us-west-1 but it will just be clone of eu-west-1 where only terragrunt.hcl file can be use to tweak the variables. The main TF code is placed inside modules. This is also helpful in automated deployment where we can control which order we want to run the TF code.

## CI / CD
There are sample CI/CD files present for Github Actions. Some key points are as follows

1. Run the plan and send email. 

2. Apply will only be done once approved.

3. Image scanning and Code scanning in place

4. This is a single repo with infrastrucure, backend and frontend only for the sake of this task. 

