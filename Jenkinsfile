## dint work we ll try again ##
pipeline {
    agent any

    environment {
        IMAGE_NAME = 'vishyswaminathan/python-image:v1'
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
       
    }
### GIT_CREDENTIALS = credentials('github-credentials-id') ###
    stages {
        stage('Clone Repo') {
            steps {
                
                git credentialsId: 'github-credentials-id', url: 'https://github.com/vishyswaminathan/pragra-docker.git'
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
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
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
            echo "Something went wrong 😞"
        }
    }
}
