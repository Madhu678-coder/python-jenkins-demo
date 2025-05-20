pipeline {
    agent any

    stages {
        stage('Environment Check') {
            steps {
                sh 'which python3'
                sh 'python3 --version'
                sh 'pip3 --version'
            }
        }

        stage('Lint') {
            steps {
                sh 'flake8 .'
            }
        }

        stage('Test') {
            steps {
                sh 'pytest'
            }
        }

        stage('Build') {
            steps {
                echo 'Build step - Add packaging or distribution logic here if needed'
            }
        }

        stage('Deploy to Staging') {
            steps {
                echo 'Deploy step - Add your deployment script here'
            }
        }
    }
}
