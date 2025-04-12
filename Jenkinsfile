// THIS JENKINS FILE FINALLY WORKED - WINNER. updated docker remove image step
// GIT_CREDENTIALS = credentials('github-credentials-id') testing AGAIN
pipeline {
    agent any

    environment {
        IMAGE_NAME = 'vishyswaminathan/python-image:v1'
    }

    stage('Clone Repo') {
    steps {
        sh """
            sudo rm -rf /opt/pragra-docker || true
            sudo git clone git@github.com:vishyswaminathan/pragra-docker.git /opt/pragra-docker
        """
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
                    
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]) {
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
                            docker.image("${IMAGE_NAME}").push("latest")
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


