pipeline {
    agent { label 'build' }

    environment {
        IMAGE_NAME = 'flaskapp-autodeployer'
        IMAGE_TAG = 'latest'
        DOCKERHUB_REPO = 'abdurahim/flaskapp-autodeployer'
        ECR_REPO = 'aws_account_id.dkr.ecr.us-east-1.amazonaws.com/flaskapp-autodeployer'
        ACR_REPO = 'myregistry.azurecr.io/flaskapp-autodeployer'
        APP_PORT = '5000'
        CONTAINER_NAME = 'flaskapp'
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage('📥 Clone Repository') {
            steps {
                echo '🔄 Cloning Git repository...'
                git branch: 'main', url: 'https://github.com/JibbranAli/devops-project-1.git'
            }
        }

        stage('📦 Install Dependencies') {
            steps {
                echo '📦 Installing Python and dependencies...'
                sh 'sudo yum install python3-pip -y'
                sh 'pip3 install -r requirements.txt'
            }
        }

        stage('✅ Run Unit Tests') {
            steps {
                echo '🧪 Running unit tests...'
                sh 'pytest'
            }
        }

        stage('🐳 Build Docker Image') {
            steps {
                echo "🐳 Building Docker image..."
                sh "docker build -t $IMAGE_NAME:$IMAGE_TAG ."
            }
        }

        stage('🔐 Login to DockerHub') {
            steps {
                echo '🔐 Logging in to DockerHub...'
                withCredentials([usernamePassword(credentialsId: 'DOCKERHUB_CREDENTIALS', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
                    sh "echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin"
                }
            }
        }

        stage('📤 Push to DockerHub') {
            steps {
                echo '📤 Pushing image to DockerHub...'
                sh """
                    docker tag $IMAGE_NAME:$IMAGE_TAG $DOCKERHUB_REPO:$IMAGE_TAG
                    docker push $DOCKERHUB_REPO:$IMAGE_TAG
                """
            }
        }

        stage('🔐 Login to AWS ECR') {
            steps {
                echo '🔐 Logging in to AWS ECR...'
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AWS_CREDENTIALS'
                ]]) {
                    sh "aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin ${ECR_REPO.split('/')[0]}"
                }
            }
        }

        stage('📤 Push to AWS ECR') {
            steps {
                echo '📤 Pushing image to AWS ECR...'
                sh """
                    docker tag $IMAGE_NAME:$IMAGE_TAG $ECR_REPO:$IMAGE_TAG
                    docker push $ECR_REPO:$IMAGE_TAG
                """
            }
        }

        stage('🔐 Login to Azure ACR') {
            steps {
                echo '🔐 Logging in to Azure ACR using Service Principal...'
                withCredentials([string(credentialsId: 'AZURE_SP_CREDENTIALS', variable: 'AZURE_CREDENTIALS_JSON')]) {
            sh '''
                echo "$AZURE_CREDENTIALS_JSON" > azure_auth.json
                az login --service-principal --username $(jq -r .clientId azure_auth.json) \
                    --password $(jq -r .clientSecret azure_auth.json) \
                    --tenant $(jq -r .tenantId azure_auth.json)

                az acr login --name <ACR_NAME>
            '''
                }
            }
        }

        stage('📤 Push to Azure ACR') {
            steps {
                echo '📤 Pushing image to Azure ACR...'
                sh """
                    docker tag $IMAGE_NAME:$IMAGE_TAG $ACR_REPO:$IMAGE_TAG
                    docker push $ACR_REPO:$IMAGE_TAG
                """
            }
        }

        stage('🚀 Deploy to AWS ECS') {
            steps {
                echo '🚀 Deploying to AWS ECS (Fargate)...'
                sh """
                    aws ecs update-service \
                      --cluster flaskapp-cluster \
                      --service flaskapp-service \
                      --force-new-deployment \
                      --region $AWS_REGION
                """
            }
        }
    }

    post {
        success {
            echo '✅ All builds and deployments succeeded!'
        }
        failure {
            echo '❌ Something went wrong. Check logs.'
        }
    }
}
