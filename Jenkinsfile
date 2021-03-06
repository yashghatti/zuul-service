pipeline {
    agent any

    environment {
        GS_SLACK_TOKEN              = credentials('GS_SLACK_TOKEN')
        GS_SLACK_DIRECT_MESSAGE_ID  = credentials('GS_SLACK_DIRECT_MESSAGE_ID')
    }

    stages {
        stage('Gradle Build') {
            steps {
                echo '==> Gradle Build'
                sh 'sudo chmod +x ./gradlew'
                sh './gradlew build'
            }
        }
        stage('Docker Build') {
            steps {
                echo '==> Docker Build'
                sh 'sudo podman build -t zuul-service --no-cache .'
            }
        }
        stage('Docker Stop Container') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    echo '==> Stopping container'
                    sh 'sudo podman rm $(sudo podman ps -aqf "name=zuul-service") -f'
                }
            }
        }
        stage('Docker Run Container') {
            steps {
                sh 'sudo podman run -p 80:80 --name zuul-service --detach --network=host zuul-service'
            }
        }
    }
}
