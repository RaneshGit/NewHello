pipeline {
    agent any
    environment {
    DOCKERHUB_CREDENTIALS = credentials('ranesh88')
    }
    tools {
        maven '3.9.12' // Use the name configured in Global Tools
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/RaneshGit/NewHello.git'
            }
        }
        stage('Build') {
            steps {
                // -B runs in non-interactive (batch) mode
                sh 'mvn -B clean package' 
                print "Image has been built"
                sh 'cp /var/lib/jenkins/workspace/Build/webapp/target/webapp.war .'
            }
        }
        stage('Build docker image') {
            steps {  
                print "starting the Image Building" 
                sh 'ls -lrt'
                sh 'docker build -t ranesh88/myjavaapp:$BUILD_NUMBER .'
            }
        }
        stage('login to dockerhub') {
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('push image') {
            steps{
                sh 'docker push ranesh88/myjavaapp:$BUILD_NUMBER'
            }
        }    
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}
