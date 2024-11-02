def gv_script
pipeline {
    agent any
    environment {
         GITHUB_URL = "https://github.com/prabhat-roy/java-deployment-eks-using-jenkins-terraform.git"
         BRANCH = "main"
         IMAGE_NAME = "java-maven-image"         
         ACC_ID = "873330726955"
         REGION = "us-east-1"
         ECR = "${ACC_ID}.dkr.ecr.${REGION}.amazonaws.com"
    }
    tools {
        jdk 'Java'
        maven 'Maven'
    }
    stages {
        stage("Init") {
            steps {
                script {
                    gv_script = load"script.groovy"
                }
            }
        }
      
        stage("Checkout from Git Repo") {
            steps {
                script {
                    gv_script.checkout()
                }
            }
        }
        
        stage("SonarQube Analysis") {
            steps {
                script {
                    gv_script.sonaranalysis()
                }
            }
        }
        
        stage("Code Compile") {
            steps {
                script {
                    gv_script.codecompile()
                }
            }
        }
        stage("Build Application") {
            steps {
                script {
                    gv_script.buildapplication()
                }
            }
        }
        stage("Docker Image") {
            steps {
                script {
                    gv_script.docker()
                }
            }
        }
        
        stage("Grype Image Scan") {
            steps {
                script {
                    gv_script.grype()
                }
            }
        }
        stage("Syft Image Scan") {
            steps {
                script {
                    gv_script.syft()
                }
            }
        }
        stage("Docker Scout Image Scan") {
            steps {
                script {
                    gv_script.dockerscout()
                }
            }
        }
        stage("AWS ECR login and push") {
            steps {
                script {
                    gv_script.ecr()
                }
            }
        }
        stage("Update kubeconfig") {
            steps {
                script {
                    gv_script.kubeconfig()
                }
            }
        }
        
    }
    
}
