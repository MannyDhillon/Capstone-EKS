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
    withCredentials([usernamePassword( credentialsId: 'dockerhub', usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
        def registry_url = "registry.hub.docker.com/"
        bat "docker login -u $USER -p $PASSWORD ${registry_url}"
        docker.withRegistry("http://${registry_url}", "dockerhub") {
      steps {
        sh 'docker push msdhillon/blueimage'
        sh 'docker push msdhillon/greenimage'
      }
    }
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
