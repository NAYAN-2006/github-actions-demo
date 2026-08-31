pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Test') {
            steps {
                sh '''
                    python3 -m venv venv
                    venv/bin/pip install -r requirements.txt
                    venv/bin/pytest
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t cicd-demo:latest .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker rm -f cicd-demo-container || true'
                sh 'docker run -d -p 5000:5000 --name cicd-demo-container cicd-demo:latest'
            }
        }

        stage('Verify Application') {
            steps {
                sh 'sleep 2'
                sh 'curl -f http://localhost:5000'
            }
        }
    }
}
