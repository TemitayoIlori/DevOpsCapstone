#!/bin/sh

echo "Pre-Build Steps:"
echo "authenticating with AWS ECR..."
aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 453111954939.dkr.ecr.us-west-2.amazonaws.com

echo "Build Steps:"
echo "building image..."
docker build -t 453111954939.dkr.ecr.us-east-1.amazonaws.com/react-docker-aws:latest .

echo "Post-Build Steps:"
echo "pushing image to AWS ECR..."
docker push 453111954939.dkr.ecr.us-east-1.amazonaws.com/react-docker-aws:latest

echo "updating AWS ECS service..."
aws ecs update-service --cluster react-cluster --service react-sc --force-new-deployment

echo "Done!"
