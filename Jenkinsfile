pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'  // replace with your ECR region
        ECR_REPO = 'demo-cicd'             // replace with your ECR repository name
        IMAGE_TAG = "latest-${BUILD_NUMBER}"
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
                    try {
                        // Authenticate Docker with ECR
                        def ecrLogin = sh(script: "aws ecr get-login-password --region ${AWS_DEFAULT_REGION}", returnStatus: true)
                        if (ecrLogin != 0) {
                            error "Failed to authenticate with ECR."
                        }

                        // Build Docker image
                        sh "docker build -t ${ECR_REPO} ."

                        // Tag Docker image
                        sh "docker tag ${ECR_REPO}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG}"

                        // Push Docker image to ECR
                        sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG}"
                    } catch (Exception e) {
                        error "Error during Docker image build and push: ${e.message}"
                    }
                }
            }
        }
    }
}
