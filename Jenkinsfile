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
            when {
                expression { return params.DEPLOY_TYPES.contains('deploy') && params.GENERATE_CLIENT }
            }
            steps {
                script {
                    sh "pwd"
                    sh "./patrick.sh ${APP_BRANCH}"
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

    post {
        success {
             script {
                def msg = """\
                        [Jenkins]
                        [${decodeJobName(env.JOB_NAME)}] complete.
                        RESULT: ${currentBuild.currentResult}
                        BUILD_URL: ${env.BUILD_URL}"""
            }
        }

        failure {
            script {
                def version = sh (
                        script: 'cat client/VERSION',
                        returnStdout: true
                    ).trim()

                def msg = """\
                        [Jenkins]
                        [${decodeJobName(env.JOB_NAME)}] complete.
                        RESULT: ${currentBuild.currentResult}
                        CURRENT_VERSION: ${version}
                        BUILD_URL: ${env.BUILD_URL}"""
            }
        }

        cleanup {
            script {
                if(params.NOTIFICATION){
                    echo $msg
                }
            }
        }
    }
}
