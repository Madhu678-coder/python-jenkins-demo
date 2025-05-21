pipeline {
    agent any
    

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                        docker build -t jenkins .
                    '''
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                sh 'docker run -d --name python jenkins'
                }
            }
        }
    }
