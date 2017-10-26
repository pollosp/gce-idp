pipeline {
  agent any
  stages {
    stage('terraform plan') {
      steps {
        sh 'make plan'
      }
    }
  }
}