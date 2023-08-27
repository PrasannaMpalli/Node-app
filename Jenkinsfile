pipeline {
    agent any

    environment {
        GIT_SSH_COMMAND = 'ssh -o StrictHostKeyChecking=no'
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
         when {
                expression {
                    // Run the stage only if changes are pushed to the main branch
                    return env.BRANCH_NAME == 'main'
                }
            }
            steps {
                script {
                         sh 's2i build . nodeshift/centos7-s2i-nodejs:latest mynode1'
                         sh 'rm -rf upload/src'
                }
            }
        }
        stage('Push to GitHub Branch') {
             when {
                expression {
                    // Run the stage only if changes are pushed to the main branch
                    return env.BRANCH_NAME == 'main'
                }
            }
            steps {
                script {
                    sh '''
                            rm -rf temp && mkdir temp 
                            cd temp
                            git config user.email "jenkins@example.com"
                            git config user.name "Jenkins"
                            git clone git@github.com:PrasannaMpalli/Node-app.git
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
