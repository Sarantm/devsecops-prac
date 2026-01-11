pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                  docker build -t devsecops-prac:${BUILD_NUMBER} .
                '''
            }
        }

        stage('Run Container (Test)') {
            steps {
                sh '''
                  docker run -d -p 5001:5000 devsecops-prac:${BUILD_NUMBER}
                  sleep 5
                  docker ps
                '''
            }
        }
    }

    post {
        always {
            sh '''
              docker rm -f $(docker ps -q --filter ancestor=devsecops-prac:${BUILD_NUMBER}) || true
            '''
        }
    }
}

