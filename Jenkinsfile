// updated the docker hub creds to PAT token and also added echo
// GIT_CREDENTIALS = credentials('github-credentials-id') 
pipeline {
    agent any

    environment {
        IMAGE_NAME = 'vishyswaminathan/python-image:v1'
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
       
    }

    stages {
        stage('Clone Repo') {
            steps {
                
                git branch: 'main', credentialsId: 'gitsshkey', url: 'git@github.com:vishyswaminathan/pragra-docker.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "Pushing to Docker Hub with image: ${IMAGE_NAME}"
                    docker.withRegistry('https://registry.hub.docker.com', DOCKERHUB_CREDENTIALS) {
                        docker.image("${IMAGE_NAME}").push("latest")
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Docker image pushed successfully to Docker Hub!"
        }
        failure {
            echo "Something went wrong "
        }
    }
}
