aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 508308164161.dkr.ecr.us-east-1.amazonaws.com
docker build -t demo-cicd .
docker tag demo-cicd:latest 508308164161.dkr.ecr.us-east-1.amazonaws.com/demo-cicd:latest
docker push 508308164161.dkr.ecr.us-east-1.amazonaws.com/demo-cicd:latest
