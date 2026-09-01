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
                    docker build -t nayan200661/cicd-demo:${BUILD_NUMBER} .
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
                        docker push nayan200661/cicd-demo:${BUILD_NUMBER}
                        docker logout
                    '''
                }
            }
        }

        stage('Deploy to Staging') {
            steps {
                sh '''
                    docker rm -f cicd-demo-staging || true

                    docker run -d -p 5000:5000 \
                        --name cicd-demo-staging \
                        nayan200661/cicd-demo:${BUILD_NUMBER}
                '''
            }
        }

        stage('Verify Staging') {
            steps {
                sh '''
                    sleep 2
                    curl -f http://localhost:5000
                '''
            }
        }

        stage('Manual Approval') {
            steps {
                input message: 'Staging verification passed. Deploy to Production?',
                      ok: 'Deploy to Production'
            }
        }

        stage('Deploy to Production') {
            steps {
                sh '''
                    docker rm -f cicd-demo-production || true

                    docker run -d -p 5001:5000 \
                        --name cicd-demo-production \
                        nayan200661/cicd-demo:${BUILD_NUMBER}
                '''
            }
        }

        stage('Verify Production') {
            steps {
                sh '''
                    sleep 2
                    curl -f http://localhost:5001
                '''
            }
        }
    }
}
