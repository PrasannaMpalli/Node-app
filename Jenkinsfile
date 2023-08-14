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
                        sh '''
             //              git config user.email "jenkins@example.com"
             //               git config user.name "Jenkins"
             //               git checkout staging
                              s2i build . nodeshift/centos7-s2i-nodejs:latest mynode1
                              rm -rf upload/src
                              s2i build . nodeshift/centos7-s2i-nodejs:latest --as-dockerfile Dockerfile
              //              git add Dockerfile
              //              git commit -m "Add Dockerfile"
              //              git push --force origin staging
                         '''
                }
            }
        }

        stage('Push to GitHub Branch') {
            steps {
                script {
                        sh '''
                            git config user.email "jenkins@example.com"
                            git config user.name "Jenkins"
                            git checkout staging
                            mv Dockerfile Dockerfile-staging
                            git add Dockerfile-staging
                            git commit -m "Add Dockerfile-staging"
                            git push --force origin staging
                        '''
                }
            }
       }
    }
}
