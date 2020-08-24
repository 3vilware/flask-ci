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
        try{
          sh 'python test.py'
        }catch(err){
          junit 'test-reports/*.xml'
          throw err
        }
      }
      post {
        always {
          junit 'test-reports/*.xml'
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
