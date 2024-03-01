pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'  // replace with your ECR region
        ECR_REPO = 'demo-cicd'        // replace with your ECR repository name
        IMAGE_TAG = sh(script: 'echo $BUILD_NUMBER', returnStdout: true).trim()
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from GitHub
                checkout scm
            }
        }

         stage('Build and Push Docker Image') {
             steps {
               script {
                     // Authenticate Docker with ECR
                     withCredentials([usernamePassword(credentialsId: 'your-ecr-credentials-id', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                         sh "aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com"
                    }

                     // Build and tag the Docker image
                     sh "docker build -t $ECR_REPO:$IMAGE_TAG ."

                     // Tag the image for ECR
                     sh "docker tag $ECR_REPO:$IMAGE_TAG $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$ECR_REPO:$IMAGE_TAG"

                     // Push the image to ECR
                     sh "docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$ECR_REPO:$IMAGE_TAG"
                 }
             }
         }
     }

}
