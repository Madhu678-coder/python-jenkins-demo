pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'lithinvarma'
        IMAGE_NAME = 'greet-app'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                        docker build -t $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG .
                    '''
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG
                    '''
                }
            }
        }

        stage('Lint') {
            steps {
                echo 'Linting...'
                // Add linter command here if needed, e.g. flake8
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run tests inside the built container
                    sh '''
                        docker run --rm $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG python -m unittest
                    '''
                }
            }
        }

        stage('Run Application') {
            steps {
                echo 'Running the application...'
                sh '''
                    docker run --rm $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG
                '''
            }
        }
    }
}
