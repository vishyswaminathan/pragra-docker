// updated the docker hub creds to PAT token and also added echo
// GIT_CREDENTIALS = credentials('github-credentials-id') 
pipeline {
    agent any

    environment {
        IMAGE_NAME = 'vishyswaminathan/python-image:v1'
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')  // This should be a 'usernamePassword' type credential in Jenkins
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
            
            // Use withCredentials to wrap the Docker Hub credentials
            withCredentials([string(credentialsId: 'dockerhub-creds', variable: 'DOCKERHUB_TOKEN')]) {
                docker.withRegistry('https://registry.hub.docker.com', DOCKERHUB_TOKEN) {
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
            echo "Something went wrong."
        }
    }
}
