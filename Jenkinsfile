#!groovy


pipeline {
	agent any
	options {
		timestamps()
		buildDiscarder(logRotator(numToKeepStr: '20'))
	}
	environment {
		PATH = '/usr/local/apache-maven-3.9.3/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin'
		DOCKERHUB_CREDENTIALS = credentials('dockerhub_id')
		VERSION = "${env.GIT_COMMIT}"
		STATUS = "xxx"
		CONTAINER_NAME = "container-app"
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

		stage('Check container') {
			steps {
				script {

					sh 'docker run --name ${CONTAINER_NAME} -d -p  8089:8080 project-app-image'
//					sh 'STATUS=curl --user "frodo@local:admin"  -i -s -o /dev/null -w "%{http_code}\\n"   http://localhost:8089/api/'
					sleep(60)
					STATUS = sh(script: 'curl -i -s -o /dev/null -w "%{http_code}" http://localhost:8089/api/', returnStdout: true).toString().trim()
					sh "echo status is ${STATUS}"
				}
			}
		}

		stage('Push to Dockerhub') {
			steps {
				script {
					if (STATUS == '401') {
						sh "echo 'Container  running!'"
						sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
						sh 'docker tag project-app-image anaega/project-app-image:${VERSION}'
						sh 'docker push anaega/project-app-image:${VERSION}'
					} else {
						sh "echo 'Container not running!'"
					}
				}
			}
		}

		stage('Deploy to Kubernetes cluster') {
			steps {
				script {
					sh 'sed -i  ' ' -E  "s/(project-app-image:)(.*)/project-app-image:$VERSION/" my-deployment.yaml'
					sh 'kubectl apply -f my-deployment.yaml'
					sh 'kubectl apply -f my-service.yaml'
					sh "echo 'TO BE DONE'"
				}
			}
		}

	}
	post {
		always {
			sh 'docker stop ${CONTAINER_NAME}'
			sh 'docker rm ${CONTAINER_NAME}'
			sh 'docker logout'
		}
	}
}

