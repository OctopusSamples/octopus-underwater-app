pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
    }
    stages {
         stage('Clone repository') { 
            steps {
                script{
                checkout scm
                }
            }
        }

        stage('Build') { 
            steps { 
                script{
                 app = docker.build("octopus-app")
                }
            }
        }
        stage('Test'){
            steps {
                 echo 'Not Empty'
            }
        }
        stage('Deploy') {
            steps {
                script{
                    docker.withRegistry('https://609039721282.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:aws-credentials') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                    }
                }
            }
        }
    }
}
