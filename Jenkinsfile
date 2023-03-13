import groovy.json.JsonOutput
pipeline {
    agent any

    environment {
        TALK_GROUP_ID = 8641
        PHASE = ''
        APP_BRANCH = ''
        BUILD_USER = ''
        }

    parameters {
        choice(name: 'DEPLOY_TYPES', choices: ['deploy', 'rollback', 'update_config', 'setup', 'restart'], description: '실행할 작업')
        booleanParam(name: 'GENERATE_CLIENT', defaultValue: false, description: '클라이언트 생성 여부')
        booleanParam(name: 'CANARY', defaultValue: false, description: '카나리 배포 여부')
        booleanParam(name: 'NOTIFICATION', defaultValue: true, description: '카톡 알림 여부')
        choice(name: 'UPDATE_CONFIG_TYPE', choices: ['all', 'fluentd'], description: '설정 업데이트 에서만 사용')
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
                    def ret = sh(script: "sh patrick.sh", returnStdout: true)
                    sh 'echo $ret'
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
