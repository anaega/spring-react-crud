pipeline {
    agent any
    options {
            timestamps()
        }
   environment {
           MAVEN_HOME= '/usr/local/apache-maven-3.9.3'
           M2_HOME= '/usr/local/apache-maven-3.9.3'
           PATH='$M2_HOME/bin:$PATH'
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
