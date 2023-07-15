pipeline {
	agent any
	options {
		timestamps()
		buildDiscarder(logRotator(numToKeepStr: '15'))
	}
	environment {
		PATH = '/usr/local/apache-maven-3.9.3/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin'
		DOCKERHUB_CREDENTIALS = credentials('dockerhub_id')
		VERSION = "${env.GIT_COMMIT}"
	}
	stages {
//     	stage('Which Java?') {
//             steps {
//             	sh 'printenv'
//                 sh 'java --version'
//                 sh 'mvn --version'
//             }
//         }

		stage('Test and Build') {
			steps {
				sh 'mvn clean verify'
			}
		}

		stage('Create Docker image') {
			steps {
				sh 'docker build -t project-app-image .'
			}
		}

		stage('Push to Dockerhub') {
			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
				sh 'docker tag project-app-image anaega/project-app-image:${VERSION}'
				sh 'docker push anaega/project-app-image:${VERSION}'

			}
		}

		stage('Check container') {
			steps {
				sh 'docker run -d -p 8089:8080 project-app-image -name container-app'
				sh 'curl -v -X GET http://localhost:8089/api/'

			}
		}
	}
	post {
		always {
			sh 'docker logout'
		}
	}
}

