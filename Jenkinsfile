
pipeline {
    agent any

    environment {
        AWS_CREDENTIALS_ID = 'AWS_CREDENTIALS_ID'
        AWS_DEFAULT_REGION = 'us-east-1'  // replace with your ECR region
        ECR_REPO = 'demo-cicd'        // replace with your ECR repository name
        IMAGE_TAG = sh(script: 'echo $BUILD_NUMBER', returnStdout: true).trim()
        AWS_ACCOUNT_ID = '508308164161'
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
                   sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 508308164161.dkr.ecr.us-east-1.amazonaws.com"
                   sh "docker build -t demo-cicd ."
                   sh "docker tag demo-cicd:latest 508308164161.dkr.ecr.us-east-1.amazonaws.com/demo-cicd:latest"
                   sh "docker push 508308164161.dkr.ecr.us-east-1.amazonaws.com/demo-cicd:latest"
                   
                 }
             }
         }
     }

}
