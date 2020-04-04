pipeline {
  environment {
    registryCredential = 'dockerhub'
    dockerImageBlue = ''
    dockerImageGreen = ''
  }
  agent any
  stages {
    stage('Linting') {
      steps {
        sh 'tidy -q -e blue-green/blue/*.html'
        sh 'tidy -q -e blue-green/green/*.html'
      }
    }

    stage('Build image') {
      steps {
        dockerImageBlue = sh 'docker build -t msdhillon/blueimage -f blue-green/blue/Dockerfile blue-green/blue'
        dockerImageGreen = sh 'docker build -t msdhillon/greenimage -f blue-green/green/Dockerfile blue-green/green'
      }
    }

    stage('Push image') {
      steps {
        docker.withRegistry( '', registryCredential ) {
        dockerImageBlue.push()
        dockerImageGreen.push()
      }
    }

    stage('Remove image') {
      steps {
        sh 'docker rmi -f msdhillon/greenimage'
        sh 'docker rmi -f msdhillon/blueimage'
      }
    }

  }
}
