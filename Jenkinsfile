pipeline {
    agent any

    environment {
        GIT_SSH_COMMAND = 'ssh -o StrictHostKeyChecking=no'
        GIT_CREDENTIALS = credentials('github')
    }
    triggers {
        GenericTrigger(
            genericVariables: [
                [
                    key: 'ref',
                    value: '$.ref'
                ]
            ],
            token: 'Demos2i'
        )
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
def triggerOnMainBranch() {
    def ref = currentBuild.rawBuild.getAction(hudson.model.CauseAction).getCauses()[0].getShortDescription()

    return ref == 'refs/heads/main'
}
