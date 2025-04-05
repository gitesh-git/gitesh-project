pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "gitesh8/gitesh-project-pipeline"  // Docker image name
        REPO_URL = "https://github.com/gitesh-git/gitesh-project.git"  // Your GitHub repository URL
        CONTAINER_NAME = "gitesh-project-pipeline"  // Name of the running container
        PORT_MAPPING = "8081:8080"  // Port mapping between host and container
        DOCKER_REGISTRY_CREDENTIALS = "dockerhub-credentials"  // Jenkins Docker Hub credentials
    }

    stages {
        // Stage to clone the Git repository
        stage('Clone Repository') {
            steps {
                git url: "${REPO_URL}"
            }
        }

        // Stage to build the Maven project
        stage('Build Maven Project') {
            steps {
                script {
                    // Use Maven to build the project
                    sh 'mvn install'
                }
            }
        }

        // Stage to build the Docker image
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image from Dockerfile
                    docker.build(DOCKER_IMAGE, "-f Dockerfile .")
                }
            }
        }

        // Stage to push the Docker image to Docker Hub
        stage('Push Docker Image') {
            steps {
                script {
                    // Login to DockerHub and push the image
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_REGISTRY_CREDENTIALS) {
                        docker.image(DOCKER_IMAGE).push('latest')
                    }
                }
            }
        }

        // Stage to deploy the Docker container
        stage('Deploy Docker Container') {
            steps {
                script {
                    // Pull the latest Docker image from Docker Hub
                    docker.image(DOCKER_IMAGE).pull()

                    // Stop and remove the existing container if it exists
                    sh """
                        docker ps -a | grep ${CONTAINER_NAME} && \
                        docker stop ${CONTAINER_NAME} && \
                        docker rm ${CONTAINER_NAME} || true
                    """

                    // Run a new container from the Docker image
                    sh """
                        docker run -itd --name ${CONTAINER_NAME} -p ${PORT_MAPPING} ${DOCKER_IMAGE}
                    """
                }
            }
        }
    }
}

