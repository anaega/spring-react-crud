pipeline {
    agent any
    options {
            timestamps()
        }
//     tools {
//           maven 'Maven 3.9.2'
//           jdk 'openjdk17'
//         }
    stages {

    	stage('Which Java?') {
            steps {
            	sh 'printenv'
                sh 'java --version'
                sh 'mvn --version'
            }
        }
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
    }
}
