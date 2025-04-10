// THIS JENKINS FILE FINALLY WORKED - WINNER. updated docker remove image step
// GIT_CREDENTIALS = credentials('github-credentials-id') testing.
pipeline {
    agent any

    environment {
        IMAGE_NAME = 'vishyswaminathan/python-image:v1'
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
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]) {
                        // Use the correct format for the registry URL without the 'docker://' prefix
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
                            docker.image("${IMAGE_NAME}").push("latest")
                        }
                    }
                }
            }
        }
         stage('Cleanup Local Docker Image') {
            steps {
                script {
                    echo "Cleaning up local Docker image to free space"
                    sh """
                         docker rmi ${IMAGE_NAME} || true
                         docker rmi vishyswaminathan/python-image:latest || true
                    """
                    
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

