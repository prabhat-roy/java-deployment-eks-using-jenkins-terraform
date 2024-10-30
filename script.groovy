def cleanup() {
        cleanWs()
}
def checkout() {
        git branch: 'main', credentialsId: 'github', url: "$GITHUB_URL"
}
def owasp() {
    dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'DP-Check'
    dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
}
def sonaranalysis() {
        withSonarQubeEnv(installationName: 'SonarQube', credentialsId: 'sonar') {
            sh "mvn sonar:sonar"
    }
}
def qualitygate() {
        waitForQualityGate abortPipeline: false, credentialsId: 'sonar'
}
def trivyfs() {
        sh "trivy fs ."
}
def codecompile() {
        sh "mvn clean compile"
}
def buildapplication() {
    sh "mvn clean install"
}

def docker() {
        sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."
}

def trivyimage() {
        sh '''
                trivy image ${IMAGE_NAME}:${BUILD_NUMBER}
        '''        
}

def grype() {
        sh '''
                grype ${IMAGE_NAME}:${BUILD_NUMBER}
        '''       
}

def syft() {
        sh '''
                syft ${IMAGE_NAME}:${BUILD_NUMBER}
          ''' 
}

def dockerscout() {
        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword} "
                sh "docker scout quickview ${IMAGE_NAME}:${BUILD_NUMBER}"
                sh "docker scout cves ${IMAGE_NAME}:${BUILD_NUMBER}"
                sh "docker scout recommendations ${IMAGE_NAME}:${BUILD_NUMBER}"
        }
}

def ecr() {
        sh '''
                aws ecr get-login-password --region ap-south-2 | docker login --username AWS --password-stdin ${ECR}
                docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${ECR}/${IMAGE_NAME}:{BUILD_NUMBER}
                docker push ${ECR}/${IMAGE_NAME}:{BUILD_NUMBER}
        '''
}

def kubeconfig() {
        sh '''
                aws eks update-kubeconfig --region ap-south-2 --name EKS-Cluster
        '''
}

def kubernetes() {
        sh "helm ls"
        sh "helm upgrade first-helm --install java-maven --set image.tag=$BUILD_NUMBER"
        sh "kubectl get svc"
        sh "kubectl get pods"
}


return this