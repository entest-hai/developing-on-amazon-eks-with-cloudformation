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

# validate stack 
aws cloudformation validate-template \
 --template-body file://1-network.yaml 

# create iam stack 
aws cloudformation validate-template \
 --template-body file://3-iam.yaml 

# create network stack
aws cloudformation update-stack \
 --stack-name  network-stack \
 --template-body file://1-network.yaml \
 --capabilities CAPABILITY_NAMED_IAM

# create eks cluster 
aws cloudformation update-stack \
 --stack-name  eks-stack \
 --template-body file://2-eks.yaml \
 --capabilities CAPABILITY_NAMED_IAM

# create iam stack 
aws cloudformation update-stack \
 --stack-name  iam-stack \
 --template-body file://3-iam.yaml \
 --capabilities CAPABILITY_NAMED_IAM

# aws eks update-kubeconfig --name eks-stack-eks-cluster
# kubectl -n kube-system get serviceaccount/ebs-csi-controller-sa -o yaml