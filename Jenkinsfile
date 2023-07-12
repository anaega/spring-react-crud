pipeline {
    agent any
    options {
            timestamps()
            buildDiscarder(logRotator(numToKeepStr: '15'))
        }
   environment {
           PATH='/usr/local/apache-maven-3.9.3/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin'
       }
   stages {
//     	stage('Which Java?') {
//             steps {
//             	sh 'printenv'
//                 sh 'java --version'
//                 sh 'mvn --version'
//             }
//         }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Create Docker image') {
        	steps {
                sh 'docker build -t project-app-image .'
            }
        }
        stage('Push to Dockerhub') {
        	steps {
//                 sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
//             	sh 'docker push anaega/project-app-image'

				withDockerRegistry([ credentialsId: "dockerhub_id", url: "" ]) {
        		dockerImage.push()
            }
        }
    }
}
