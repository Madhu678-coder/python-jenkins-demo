pipeline {
    agent {
        docker {
            image 'docker:20.10.7'  // Use a Docker image with Docker CLI
            args '-v /var/run/docker.sock:/var/run/docker.sock'  // Mount Docker socket
        }
    }

    environment {
        DOCKERHUB_USER = 'yourdockerhubusername'
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
                withCredentials([usernamePassword(credentialsId: 'docker_creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push $DOCKERHUB_USER/$IMAGE_NAME:$IMAGE_TAG
                    '''
                }
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
