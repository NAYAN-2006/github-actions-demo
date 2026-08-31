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
                sh '''
                    docker build -t nayan200661/cicd-demo:latest .
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'nayan200661',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                        docker push nayan200661/cicd-demo:latest
                        docker logout
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                    docker rm -f cicd-demo-container || true
                    docker run -d -p 5000:5000 \
                        --name cicd-demo-container \
                        nayan200661/cicd-demo:latest
                '''
            }
        }

        stage('Verify Application') {
            steps {
                sh '''
                    sleep 2
                    curl -f http://localhost:5000
                '''
            }
        }
    }
}
