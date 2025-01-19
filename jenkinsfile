pipeline {
    agent any

    environment {
        IMAGE_NAME = 'dictionary_app'
        CONTAINER_NAME = 'dictionary_app'
        HOST_PORT = '8082'
        CONTAINER_PORT = '80'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/mohkittaneh/dictionary_app.git'
            }
        }
        stage('Build') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }
        stage('Deploy') {
            steps {
                sh """
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true
                """

                sh """
                docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${CONTAINER_NAME} ${IMAGE_NAME}
                """
            }
        }
        stage('Health Check') {
            steps {
                sh "curl -f http://localhost:${HOST_PORT} || exit 1"
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
            sh "docker logs ${CONTAINER_NAME} > docker_logs.txt || true"
            archiveArtifacts artifacts: 'docker_logs.txt', allowEmptyArchive: true
        }
    }
}

