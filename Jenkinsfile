pipeline {
	agent any
    options {
            timestamps()
            buildDiscarder(logRotator(numToKeepStr: '15'))
        }
   	environment {
           PATH='/usr/local/apache-maven-3.9.3/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin'
//           registry = "anaega/app"
//           registryCredential = 'dockerhub_id'
//           dockerImage = ''
	   DOCKERHUB_CREDENTIALS = credentials('dockerhub_id')


       }
   	stages {
//     	stage('Which Java?') {
//             steps {
//             	sh 'printenv'
//                 sh 'java --version'
//                 sh 'mvn --version'
//             }
//         }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Create Docker image') {
        	steps {
                sh 'docker build -t project-app-image .'
            }
        }

        stage('Push to Dockerhub') {

			steps {
//				script {
//					docker.withRegistry( '', registryCredential ) {
//						dockerImage.push()
//						}
//					}
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
				sh 'docker push anaega/app:project-app-image'
        		}
	post {
		always {
			sh 'docker logout'
				}
			}
		}
    }
}
