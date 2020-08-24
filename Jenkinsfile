pipeline {
    environment {
    registry = "3vilware/flask-app"
    registryCredential = 'docker-hub-access'
    dockerImage = ''

  }
  agent { 
      docker { 
        image 'python:3.7.2' 
        args '--user 0:0'	
      } 
    }  
  stages {
    stage('build') {
      steps {
        sh 'pip install -r requirements.txt'
      }
    }
    stage('test') {
      steps {
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
    stage('deploy') {
       steps {
        echo "BUILD IS STARTING TO BE DEPLOYED..."      
      }
    }
    stage('Building image') {
      agent { 
        docker { 
          image 'docker' 
        } 
      }  
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
    stage('Deploy Image') {
      agent { 
        docker { 
          image 'docker' 
        } 
      }  
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
  }
post {
    always {
      echo "Send notifications for result: ${currentBuild.result}"
    }
  }
}
