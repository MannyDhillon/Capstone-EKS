pipeline {
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
        sh 'docker build -t msdhillon/blueimage -f blue-green/blue/Dockerfile blue-green/blue'
        sh 'docker build -t msdhillon/greenimage -f blue-green/green/Dockerfile blue-green/green'
      }
    }
    stage('Push image') {
      steps{
        script {
          checkout scm 
          docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        sh 'docker push msdhillon/blueimage:latest'
                        sh 'docker push msdhillon/greenimage:latest'
          }           
        }
      }
    }
    stage('Remove image') {
      steps {
        sh 'docker rmi -f msdhillon/greenimage:latest'
        sh 'docker rmi -f msdhillon/blueimage:latest'
      }
    }
  }
}
