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
	}
	stages {
//     	stage('Which Java?') {
//             steps {
//             	sh 'printenv'
//                 sh 'java --version'
//                 sh 'mvn --version'
//             }
//         }

//		stage('Test and Build') {
//			steps {
//				sh 'mvn clean verify'
//			}
//		}

//		stage('Create Docker image') {
//			steps {
//				sh 'docker build -t project-app-image .'
//			}
//		}

		stage('Check container') {
			steps {
				script {

//					sh 'docker run --name container-app -d -p  8089:8080 project-app-image'
//					sh 'HTTP_STATUS=curl --user "frodo@local:admin"  -i -s -o /dev/null -w "%{http_code}\\n"   http://localhost:8089/api/'
					sleep(60)
					sh ' def HTTP_STATUS=$(curl -i -s -o /dev/null -w "%{http_code}" http://localhost:8089/api/)'
					env.$HTTP_STATUS = HTTP_STATUS
					sh 'echo $HTTP_STATUS'
				}

			}
		}

		stage('Push to Dockerhub') {
			steps {
				script {
					if (env.HTTP_STATUS == '401') {
//						sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
//						sh 'docker tag project-app-image anaega/project-app-image:${VERSION}'
//						sh 'docker push anaega/project-app-image:${VERSION}'
						sh "echo 'Container  running!'"
					} else {
						sh "echo 'Container not running!'"
					}
				}
			}
		}

	}
	post {
		always {
			sh 'docker logout'
		}
	}
}

