pipeline {
    agent {
        label 'Slave_Mac'
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
        disableConcurrentBuilds()
    }

    stages {
        stage('Check sdk version') {
            steps {
                echo '------------>Check Enviroment<------------'
                sh 'flutter --version'
            }
        }

        stage('Build') {
            steps {
                echo '------------>Build<------------'
                sh 'flutter build apk --debug'
            }
        }

        stage('Domain Tests') {
            steps {
                echo '--------->Domain Tests<--------'
                dir('./modules/domain/') {
                    sh 'flutter test --coverage'
                }
            }
        }

        stage('Infrastructure Tests') {
            steps {
                echo '---->Infrastructure Tests<-----'
                dir('./modules/infrastructure/') {
                    sh 'flutter test --coverage'
                }
            }
        }

        stage('Presentation Tests') {
            steps {
                echo '---->Presentation Tests<-------'
                sh 'flutter test --coverage'
            }
        }

        stage('Static Code Analysis') {
            steps {
                echo '------------>Análisis estático de código<------------'
                withSonarQubeEnv('Sonar') {
                    sh "${tool name: 'SonarScanner-Mac', type:'hudson.plugins.sonar.SonarRunnerInstallation'}/bin/sonar-scanner"
                }
            }
        }
    }

    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if successful'
        }
        failure {
            echo 'This will run only if failed'
        }
        unstable {
            echo 'This will run only if the run was marked as unstable'
        }
        changed {
            echo 'This will run only if the state of the Pipeline has changed'
            echo 'For example, if the Pipeline was previously failing but is now successful'
        }
    }
}
