#!groovy


pipeline {
	agent any

	options {
		timestamps()
		buildDiscarder(logRotator(numToKeepStr: '20'))
	}
	environment {
		PATH = '/usr/local/apache-maven-3.9.3/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin'
		VERSION = "${env.GIT_COMMIT}"
		STATUS = "xxx"
		CONTAINER_NAME = "container-app"
	}
	stages {
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
					echo "Waiting for the application in container to start..."
					sleep(80)
					withCredentials([usernamePassword(credentialsId: 'app_credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
						STATUS = sh(script: 'curl -u $USERNAME:$PASSWORD -i -s -o /dev/null -w "%{http_code}" http://localhost:8089/api/', returnStdout: true).toString().trim()
						echo "HTTP status is ${STATUS}"
					}
				}
			}
		}

		stage('Push to Dockerhub') {
			steps {
				script {
					if (STATUS == '200') {
						echo "Container  running!"
						sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
						sh 'docker tag project-app-image anaega/project-app-image:${VERSION}'
						sh 'docker push anaega/project-app-image:${VERSION}'
					} else {
						echo "Container not running!"
					}
				}
			}
		}

		stage('Deploy to Kubernetes cluster') {
			steps {
				script {
					sh '''sed -i  ' ' -E  "s/(project-app-image:)(.*)/project-app-image:$VERSION/" my-deployment.yaml'''
					sh 'cat my-deployment.yaml | grep $VERSION'
					sh 'kubectl apply -f my-deployment.yaml'
					sh 'kubectl apply -f my-service.yaml'
					echo "Waiting for the application in kubernetes to start..."
					sleep(80)
					withCredentials([usernamePassword(credentialsId: 'app_credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
						STATUS = sh(script: 'curl -u $USERNAME:$PASSWORD -i -s -o /dev/null -w "%{http_code}" http://localhost:8090/api/', returnStdout: true).toString().trim()
						echo "HTTP status is ${STATUS}"
					}
					echo "DEPLOYMENT DONE"
				}
			}
		}

	}
	post {
		always {
			echo "Cleaning up..."
			sh 'docker stop ${CONTAINER_NAME}'
			sh 'docker rm ${CONTAINER_NAME}'
			sh 'docker logout'
		}
	}
}

