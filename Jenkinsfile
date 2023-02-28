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
      steps {
            withKubeConfig([credentialsId: 'kubernetes-config']) {  
                 sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"'  
                 sh 'chmod u+x ./kubectl'  
                 sh './kubectl apply -f deployment.yml'  
            }
        }

    }
}
