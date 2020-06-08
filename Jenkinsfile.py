pipeline {
    agent any

    environment{
        NAME = 'Julio'
    }

    stages {
        stage('Build'){
            steps{
                sh 'python --version'
                echo 'Building...'
            }
        }
        stage('Test'){
            steps{
                echo 'Testing'
            }
        }
        stage('Deploy'){
            steps{
                sh 'echo $NAME is Deploying'
            }
        }
    }
    post {
        always{
            echo 'Will be executed always'
        }
        success{
            echo 'Only when success'
        }
        failure{
            echo 'Only when failure'
        }
        unstable{
            echo 'Unstable'
        }
        changed{
            echo 'Changes found'
        }
    }
}