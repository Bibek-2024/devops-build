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
        usernameVariable: 'USERNAME',
        passwordVariable: 'PASSWORD'
    )]) {

     sh '''
     echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin
     docker tag my-react-app $DOCKER_USER/dev:latest
     docker push $DOCKER_USER/dev:latest
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
        usernameVariable: 'USERNAME',
        passwordVariable: 'PASSWORD'
    )]) {

     sh '''
     echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin
     docker tag my-react-app $DOCKER_USER/prod:latest
     docker push $DOCKER_USER/prod:latest
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
