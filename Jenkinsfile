pipeline {
    agent any
    environment {
    DOCKERHUB_CREDENTIALS = credentials('ranesh88')
    AWS_REGION = 'ap-south-1' // Change to your region
    CLUSTER_NAME = 'Ranesh-Clutser' // Change to your cluster name
    AWS_CRED_ID = 'aws-eks-cred' // The ID of your credentials in Jenkins    
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
        stage('Configure Kubeconfig') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${AWS_CRED_ID}"]]) {
                    sh "aws eks update-kubeconfig --region ${AWS_REGION} --name ${CLUSTER_NAME}"
                }
            }
        }
        stage('Deploy to EKS') {
            steps {
                // Assuming your manifest is named deployment.yaml in the root
                sh "kubectl apply -f deployment.yaml"
            }
        }
        stage('Verify') {
            steps {
                sh "kubectl get pods"
                sh "kubectl get svc"
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}
