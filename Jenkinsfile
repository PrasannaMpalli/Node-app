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
                         sh 's2i build . nodeshift/centos7-s2i-nodejs:latest mynode1'
                         sh 'rm -rf upload/src'
                }
            }
        }
        stage('Push to GitHub Branch') {
            steps {
                script {
                    sh '''
                            rm -rf temp && mkdir temp 
                            cd temp
                            git clone https://github.com/PrasannaMpalli/Node-app.git
                            git clean -f
                            cd Node-app
                            git checkout staging
                            s2i build . nodeshift/centos7-s2i-nodejs:latest --as-dockerfile Dockerfile
                            git add Dockerfile
                            git commit -m "Add Dockerfile-staging"
                            git push --force origin staging
                        '''
                }
            }
       }
    }
}
