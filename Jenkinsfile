pipeline {

 agent any

 environment {
  DOCKERHUB_USER = "bibekdec2022"
  IMAGE_NAME = "my-react-app"
 }

 stages {

  stage('Checkout Code') {
   steps {
    git branch: "dev",
    url: 'https://github.com/Bibek-2024/devops-build.git'
   }
  }

  stage('Build Docker Image') {
   steps {
    sh 'bash scripts/build.sh'
   }
  }

  stage('Push DEV Image') {

   when {
    branch 'dev'
   }

   steps {

    withCredentials([usernamePassword(
        credentialsId: 'dockerhub-creds',
        usernameVariable: 'DOCKER_USER',
        passwordVariable: 'DOCKER_PASS'
    )]) {

     sh '''
     echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
     docker tag my-react-app $DOCKERHUB_USER/dev:latest
     docker push $DOCKERHUB_USER/dev:latest
     '''

    }

   }

  }

  stage('Push PROD Image') {

   when {
    branch 'master'
   }

   steps {

    withCredentials([usernamePassword(
        credentialsId: 'dockerhub-creds',
        usernameVariable: 'DOCKER_USER',
        passwordVariable: 'DOCKER_PASS'
    )]) {

     sh '''
     echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
     docker tag my-react-app $DOCKERHUB_USER/prod:latest
     docker push $DOCKERHUB_USER/prod:latest
     '''

    }

   }

  }

  stage('Deploy') {
   steps {
    sh "bash scripts/deploy.sh ${env.BRANCH_NAME}"
   }
  }

 }

}
