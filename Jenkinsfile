pipeline {
    agent any

    environment {
        GIT_CREDENTIALS = credentials('github')
    }

    stages {
        stage('Checkout Source Code') {
            steps {
                script {
                    checkout([$class: 'GitSCM', branches: [[name: 'main']], userRemoteConfigs: [[url: 'https://github.com/PrasannaMpalli/Node-app.git']]])
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 's2i build . nodeshift/centos7-s2i-nodejs:latest mynode'
                    sh 's2i build . nodeshift/centos7-s2i-nodejs:latest --as-dockerfile Dockerfile'
                }
            }
        }

        stage('Push to GitHub Branch') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: github, usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh '''
                            git config user.name "PrasannaMpalli"
                            git checkout staging
                            git add Dockerfile
                            git commit -m "Add Dockerfile"
                            git push --force origin staging
                        '''
                    }
                }
            }
        }
    }
}
