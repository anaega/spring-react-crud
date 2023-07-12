pipeline {
    agent any
    options {
            timestamps()
        }
   environment {
//            MAVEN_HOME= '/usr/local/apache-maven-3.9.3'
//            M2_HOME= '/usr/local/apache-maven-3.9.3'
           PATH='/usr/local/apache-maven-3.9.3/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin'
       }
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
