pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'bibekdec2022'
        IMAGE_NAME     = 'my-react-app'
    }

    options {
        skipDefaultCheckout()  // We'll handle checkout manually
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    stages {

        stage('Checkout') {
            steps {
                cleanWs()

                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/dev']],   // adjust if you want parameterized branch
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [
                        [$class: 'CleanBeforeCheckout'],
                        [$class: 'LocalBranch', localBranch: 'dev']
                    ],
                    userRemoteConfigs: [[
                        url: 'https://github.com/Bibek-2024/devops-build.git',
                        credentialsId: 'github-cred'
                    ]]
                ])

                sh 'git branch -a'
                sh 'git status'

                script {
                    env.BRANCH_NAME = sh(script: "git rev-parse --abbrev-ref HEAD", returnStdout: true).trim()
                    echo "Detected branch: ${env.BRANCH_NAME}"
                }
            }
        }

        stage('Build') {
            steps {
                sh 'scripts/build.sh'
            }
        }

        stage('Push Image') {
            when {
                expression { return env.BRANCH_NAME == 'dev' || env.BRANCH_NAME == 'main' }
            }
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'

                    script {
                        def branch = env.BRANCH_NAME
                        echo "Pushing Docker image for branch: $branch"

                        if (branch == 'dev') {
                            sh """
                                docker tag $IMAGE_NAME:latest $DOCKERHUB_USER/dev:latest
                                docker tag $IMAGE_NAME:latest $DOCKERHUB_USER/dev:${BUILD_NUMBER}
                                docker push $DOCKERHUB_USER/dev:latest
                                docker push $DOCKERHUB_USER/dev:${BUILD_NUMBER}
                            """
                        } else if (branch == 'main') {
                            sh """
                                docker tag $IMAGE_NAME:latest $DOCKERHUB_USER/prod:latest
                                docker tag $IMAGE_NAME:latest $DOCKERHUB_USER/prod:${BUILD_NUMBER}
                                docker push $DOCKERHUB_USER/prod:latest
                                docker push $DOCKERHUB_USER/prod:${BUILD_NUMBER}
                            """
                        }
                    }
                }
            }
        }

        stage('Deploy') {
            when {
                expression { return env.BRANCH_NAME == 'dev' || env.BRANCH_NAME == 'main' }
            }
            steps {
                sh 'scripts/deploy.sh'
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}
