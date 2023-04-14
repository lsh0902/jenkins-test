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
        failure {
             script {
                def msg = """\
                        [Jenkins] fail"""

                if(params.NOTIFICATION){
                    sh "echo $msg"
                }
            }
        }

        success {
            script {
                sh "ls"
                def ret = sh(script: "cat VERSION", returnStdout: true)

                def msg = """\
                        [Jenkins]
                        RESULT: ${version}"""

                if(params.NOTIFICATION){
                    sh "echo $msg"
                }
            }
        }
        
        cleanup {
            script {
                sh "clean upup"
                sh "echo $msg"
            }
        }
    }
}
