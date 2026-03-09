pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from GitHub...'
                checkout scm
            }
        }
        
        stage('Build WAR') {
            steps {
                echo 'Building WAR file with Maven...'
                bat 'mvn clean package'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat 'docker build -t liberty-poc .'
            }
        }
        
        stage('Deploy Container') {
            steps {
                echo 'Deploying container...'
                bat 'docker stop liberty-app || true'
                bat 'docker rm liberty-app || true'
                bat 'docker run -d -p 9080:9080 --name liberty-app liberty-poc'
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed successfully! App is live.'
        }
        failure {
            echo 'Pipeline failed! Check logs above.'
        }
    }
}