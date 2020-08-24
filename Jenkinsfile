pipeline {
    environment {
    registry = "3vilware/flask-app"
    registryCredential = 'docker-hub-access'
    dockerImage = ''

  }
  agent none
  stages {
    stage('Build') {
      steps {
       echo "COMPILING...."
      }
    }
    stage('Test') {
      agent { docker { 
        image 'python:3.7.2' 
        args '--user 0:0'	
      } }
      steps {
          sh 'pip install -r requirements.txt'
          sh 'python test.py'
      }
      post {
        always {
          junit 'test-reports/*.xml'
        }
        failure{
          error('Build is aborted. The testing stage fails')
        }
      }       
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Testing Image' ) {
      agent {
          docker { image '3vilware/flask-app:$BUILD_NUMBER' }
      }
      steps {
          sh 'python --version'
      }
    } 
    stage('Pushing Image') { 
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Deploy STG') {
       steps {
        echo "BUILD IS STARTING TO BE DEPLOYED..."      
      }
    }
    stage('Deploy Prod') {
       steps {
        echo "BUILD IS STARTING TO BE DEPLOYED..."      
      }
    }
  }
post {
    always {
      echo "Send notifications for result: ${currentBuild.result}"
    }
  }
}
