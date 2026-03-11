pipeline {
    agent any

    environment {
        DOCKER_USER = "bibekdec2022"
        IMAGE_NAME = "my-react-app"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                // Ensure this script tags the image as 'my-react-app'
                sh 'bash scripts/build.sh'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USERNAME',
                    passwordVariable: 'PASSWORD'
                )]) {
                    sh 'echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin'
                    
                    script {
                        if (env.BRANCH_NAME == 'dev') {
                            sh "docker tag ${IMAGE_NAME} ${DOCKER_USER}/dev:latest"
                            sh "docker push ${DOCKER_USER}/dev:latest"
                        } else if (env.BRANCH_NAME == 'main') {
                            sh "docker tag ${IMAGE_NAME} ${DOCKER_USER}/prod:latest"
                            sh "docker push ${DOCKER_USER}/prod:latest"
                        }
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                // This command ensures the monitoring stack stays up 
                // while updating the react-app to the latest build
                sh "docker compose -f docker/docker-compose.yml up -d"
            }
        }
    }
}
