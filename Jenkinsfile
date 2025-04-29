// THIS JENKINS FILE FINALLY WORKED - WINNER. updated docker remove image step
// GIT_CREDENTIALS = credentials('github-credentials-id') testing AGAIN
// added trivy installation and scan stage

pipeline {
    agent any

    environment {
        IMAGE_NAME = 'vishyswaminathan/python-image:v1'
    }

    stages {
        stage('Clone Repo') {
            steps {
                sh """
                     sudo rm -rf /opt/pragra-docker || true
                     sudo git clone git@github.com:vishyswaminathan/pragra-docker.git /opt/pragra-docker
                     sudo chown -R jenkins:jenkins /opt/pragra-docker
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
       
stage('Install Trivy') {
    steps {
        script {
            echo "Checking if Trivy is installed..."
            sh """
                if ! command -v trivy > /dev/null; then
                    echo "Trivy not found. Installing latest version..."
                    sudo apt-get update -y
                    sudo apt-get install wget -y
                    wget -q https://github.com/aquasecurity/trivy/releases/latest/download/trivy_0.61.1_Linux-64bit.deb -O trivy_latest.deb
                    sudo dpkg -i trivy_latest.deb
                    rm trivy_latest.deb
                else
                    echo "Trivy already installed."
                fi
            """
        }
    }
}



        stage('Trivy Scan') {
            steps {
                script {
                    echo "Scanning Docker image with Trivy"
                    sh """
                        trivy image --exit-code 1 --severity CRITICAL,HIGH ${IMAGE_NAME}
                    """
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


