# environment variables
export IMAGE_NAME="book-app"
export REGION="ap-southeast-1"
ACCOUNT=$(aws sts get-caller-identity | jq -r '.Account')
# build docker image
sudo docker build -t $IMAGE_NAME . 
# login aws ecr
aws ecr get-login-password --region $REGION | sudo docker login --username AWS --password-stdin $ACCOUNT.dkr.ecr.$REGION.amazonaws.com
# get docker image id 
IMAGE_ID=$(sudo docker images -q $IMAGE_NAME:latest)
# tag docker image
sudo docker tag $IMAGE_ID $ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$IMAGE_NAME:latest
# push image to ecr 
sudo docker push $ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$IMAGE_NAME:latest