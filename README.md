---
title: developing on amazon eks with cloudformation
author: hai tran
date: 26/10/2024 
---

## Introduction 

## Deploy EKS Cluster

Let deploy an Amazon EKS cluster using CloudFormation. 

```bash
# create network stack 
aws cloudformation create-stack \
 --stack-name  eks-network-stack \
 --template-body file://1-network.yaml \
 --capabilities CAPABILITY_NAMED_IAM

# create eks stack
aws cloudformation create-stack \
 --stack-name  eks-cluster-stack \
 --template-body file://2-eks.yaml \
 --capabilities CAPABILITY_NAMED_IAM

# create iam stack
aws cloudformation create-stack \
 --stack-name  eks-iam-stack \
 --template-body file://3-iam.yaml \
 --parameters '[{"ParameterKey":"EksStackName","ParameterValue":"eks-cluster-stack"}]' \
 --capabilities CAPABILITY_NAMED_IAM
```

## Setup Kubectl 

First, follow [aws docs kubectl](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html)

```bash
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.30.4/2024-09-11/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
kubectl version
```

Second, update the eks and kubectl configuration. 

```bash
aws eks update-kubeconfig --name eks-cluster-stack-eks-cluster
```

Third, validate the kubectl client working. 

```bash
kubectl get nodes -A
```

## Troubleshooting

Install [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

Install [docker on redhat](https://docs.docker.com/engine/install/rhel/)

```bash
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
docker --version
```

Fix error "Cannot connect to the Docker deamon".

```bash

```