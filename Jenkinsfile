pipeline {
  environment {
    imagename = "helloworld"
    ecrurl = "298436085140.dkr.ecr.us-east-1.amazonaws.com"
    ecrcredentials = "ecr:us-east-i:helloworld"
    dockerImage = ''
  } 
  agent any
  stages {
    stage('Cloning Git') {
      steps {
                checkout scm

      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build imagename
        }
      }
    }
   
    stage('Push') {
      steps {
        script{
          docker.withRegistry("https://298436085140.dkr.ecr.us-east-1.amazonaws.com", "ecr:us-east-1:my.aws.credentials") {
            docker.image("helloworld").push()
          }
        }
      }
    }
    
    stage('Deploy'){
            withKubeConfig[my.aws.credentials: (serverUrl='https://78684FEE191971685B9D16FD501C6DA4.gr7.us-east-1.eks.amazonaws.com')] {
               sh 'kubectl apply -f deployment.yml'
            }
        }

    }
}

