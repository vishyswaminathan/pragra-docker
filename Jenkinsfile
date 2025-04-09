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
                    // Unpacking credentials into username and password
                    def dockerUsername = DOCKERHUB_CREDENTIALS_USR
                    def dockerPassword = DOCKERHUB_CREDENTIALS_PSW
                    echo "Using username: ${dockerUsername}"
                    
                    // Authenticating and pushing the image to Docker Hub
                    docker.withRegistry('https://registry.hub.docker.com', dockerUsername, dockerPassword) {
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
