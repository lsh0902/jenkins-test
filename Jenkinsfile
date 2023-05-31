import groovy.json.JsonOutput
pipeline {
    agent any

    environment {
        TALK_GROUP_ID = 8641
        PHASE = ''
        APP_BRANCH = 'master'
        BUILD_USER = ''
    }

    parameters {
        choice(name: 'DEPLOY_TYPES', choices: ['deploy', 'restart'], description: '실행할 작업')
        booleanParam(name: 'GENERATE_CLIENT', defaultValue: true, description: '클라이언트 생성 여부')
        string(name: 'SERIAL_NUMBER', defaultValue: '100%', description: '1번에 배포할 서버 수')
        booleanParam(name: 'NOTIFICATION', defaultValue: true, description: '카톡 알림 여부')

    }

    stages {

        stage('client_gen') {
            steps {

                script {
                    def FLAG = sh(script: "git diff --shortstat HEAD HEAD~1 VERSION | wc -l", returnStdout: true).trim()

                    if ( FLAG != '0' || params.DEPLOY_TYPES.contains('deploy') && params.GENERATE_CLIENT ) {
                        sh "pwd"
                        sh "./patrick.sh ${APP_BRANCH}"
                        sh 'cat VERSION'
                    }
                }
            }
        }

        stage('deploy') {
            steps {
                script {
                    def target_dir = "./hi.yaml"

                    def token = input(
                        id: "code",
                        message: "Enter the yml file from ${target_dir}",
                        parameters: [
                                string(name: 'TOKEN', defaultValue: '', description: 'code')
                        ]
                    )

                    writeFile(token, target_dir)
                }
            }
        }
    }

    post {
        always {
            script {

                def msg = "[Jenkins] hi---hi"
                msg = msg.replaceAll("---", "")
                echo "${msg}"
            }
        }
    }
}

def writeFile(token, filePath){
    token = token.replaceAll("---", "")

    sh "echo -n ${token}"

    def parsedToken = token.split('\'')

    sh "echo -n ${parsedToken[0]}"
    sh "echo -n ${parsedToken[1]}"

    sh "echo -n ${parsedToken[0]} > ${filePath}"
    sh "echo -n \\' >> ${filePath}"
    sh "echo -n ${parsedToken[1]} >> ${filePath}"
    sh "echo -n \\' >> ${filePath}"

    sh "echo ${parsedToken.size()}"
}
