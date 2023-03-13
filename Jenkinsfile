import groovy.json.JsonOutput
pipeline {
    agent any

    environment {
        TALK_GROUP_ID = 8641
        PHASE = ''
        APP_BRANCH = 'alpha'
        BUILD_USER = ''
        }

    parameters {
        choice(name: 'DEPLOY_TYPES', choices: ['deploy', 'restart'], description: '실행할 작업')
        booleanParam(name: 'GENERATE_CLIENT', defaultValue: true, description: '클라이언트 생성 여부')
        string(name: 'SERIAL_NUMBER', defaultValue: '100%', description: '1번에 배포할 서버 수')
    }

    stages {
        stage('client_gen') {
            when {
                expression { return params.DEPLOY_TYPES.contains('deploy') && params.GENERATE_CLIENT }
            }
            steps {
                script {
                    sh "pwd"
                    def ret = sh(script: "sh patrick.sh ${APP_BRANCH}", returnStdout: true)
                    sh 'cat VERSION'
                }
            }
        }

        stage('deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
