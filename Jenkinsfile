pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "shouravawasthi/trend-app:v2"
    }

    stages {

                stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-creds', url: '']) {
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yml'
                sh 'kubectl apply -f k8s/service.yml'
                sh 'kubectl rollout restart deployment/trend-deployment'
            }
        }
    }

    post {
        success {
            echo "Successfully built, pushed, and deployed ${DOCKER_IMAGE} to EKS!"
        }
        failure {
            echo "Build failed. Please check the Console Output."
        }
    }
}