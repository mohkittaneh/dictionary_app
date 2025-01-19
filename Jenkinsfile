pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[url: 'https://github.com/mohkittaneh/dictionary_app.git']]
                )
            }
        }
        stage('Build') {
            steps {
                sh 'docker build -t dictionary_app .'
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                docker stop dictionary_app || true
                docker rm dictionary_app || true
                docker run -d -p 8082:80 --name dictionary_app dictionary_app
                '''
            }
        }
        stage('Health Check') {
            steps {
                script {
                    try {
                        sh 'curl -v http://localhost:8082'
                    } catch (Exception e) {
                        sh 'docker logs dictionary_app'
                        error("Health check failed! Check the logs above.")
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}
