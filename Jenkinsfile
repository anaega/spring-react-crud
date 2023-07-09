pipeline {
    agent any
    tools {
          maven 'Maven 3.9.2'
          jdk 'jdk17'
        }
    stages {
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
