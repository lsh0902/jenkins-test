import groovy.json.JsonOutput
pipeline {
    agent any

    environment {
        BUILD_USER = "${APP_BRANCH}"
        TALK_GROUP_ID = ''
        PHASE = ''
        APP_BRANCH = 'master'
        CLIENT_VERSION_UPDATED = false
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
                    def WATCH_TOWER_GROUP = [dev: 111, prod: 2222]
                    TALK_GROUP_ID = WATCH_TOWER_GROUP["dev"]
                    CLIENT_VERSION_UPDATED = true
                }
            }
        }

        stage('deploy') {
            steps {
                script {
                    def target_dir = "./hi.yaml"
                }
            }
        }
    }

    post {
        always {
            script {

                def msg = "[Jenkins] hi---hi"
                msg = msg.replaceAll("---", "")
                if (CLIENT_VERSION_UPDATED) {
                    echo "${msg} ${params.GENERATE_CLIENT} ${BUILD_USER} ${TALK_GROUP_ID}"
                }
            }
        }
    }
}

def writeFile(token, filePath){
    token = token.replaceAll("---", "")
    sh "echo -n ${token} > ${filePath}"
    sh "sed -i \"s/ / '/g\" ${filePath}"
    sh "echo \\' >> ${filePath}"
}
