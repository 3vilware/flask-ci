pipeline {
  agent { docker { 
	image 'python:3.7.2' 
	args '--user 0:0'	
  } }
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
	  if(currentBuild.result == 'FAILURE'){
	  	return
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
