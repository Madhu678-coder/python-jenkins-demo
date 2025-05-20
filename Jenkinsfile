pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Environment Check') {
            steps {
                sh 'which python || which python3'
                sh 'python --version || python3 --version'
                sh 'pip --version || pip3 --version'
                sh 'ls -l'
            }
        }

        stage('Setup') {
            steps {
                sh '''
                    python3 -m pip install --upgrade pip
                    pip3 install -r requirements.txt
                '''
            }
        }

        stage('Lint') {
            steps {
                sh 'flake8 app/ tests/ || true'  // allow lint to fail without breaking pipeline
            }
        }

        stage('Test') {
            steps {
                sh '''
                    pytest --cov=app tests/ --junitxml=pytest-results.xml
                '''
            }
            post {
                always {
                    junit 'pytest-results.xml'
                }
            }
        }

        stage('Build') {
            steps {
                sh '''
                    pip3 install wheel
                    python3 setup.py bdist_wheel
                '''
            }
            post {
                success {
                    archiveArtifacts artifacts: 'dist/*.whl', fingerprint: true
                }
            }
        }

        stage('Deploy to Staging') {
            steps {
                echo 'Deploying to staging environment...'
                sh 'mkdir -p staging && cp dist/*.whl staging/'
            }
        }
    }
}
