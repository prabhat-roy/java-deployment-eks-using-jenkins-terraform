sudo hostnamectl set-hostname jenkins-agent
sudo apt-get update && sudo apt-get upgrade -y
cd /opt
sudo apt-get install git wget unzip curl python3 python3-pip -y
sudo apt-get install wget apt-transport-https gnupg lsb-release -y
sudo curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sudo sh -s -- -b /usr/local/bin
sudo curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sudo sh -s -- -b /usr/local/bin
sudo curl -fsSL https://raw.githubusercontent.com/docker/scout-cli/main/install.sh -o install-scout.sh
sudo apt-get -y install ansible
sudo apt-get install openjdk-21-jdk -y
sudo apt-get install docker.io -y
sudo chmod 777 /var/run/docker.sock
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG sudo ubuntu
sudo usermod -aG docker ubuntu
sudo curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
sudo sed -i 's/#PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart ssh.service
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo rm -rf awscliv2.zip
sudo ./aws/install
sudo wget https://get.helm.sh/helm-v3.16.0-rc.1-linux-amd64.tar.gz
sudo tar xvf helm-v3.16.0-rc.1-linux-amd64.tar.gz
sudo rm -rf helm-v3.16.0-rc.1-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin
sudo rm -rf linux-amd64
helm version
sudo wget https://github.com/aquasecurity/trivy/releases/download/v0.55.0/trivy_0.55.0_Linux-64bit.deb
sudo dpkg -i trivy_0.55.0_Linux-64bit.deb
sudo wget https://github.com/jeremylong/DependencyCheck/releases/download/v11.1.0/dependency-check-11.1.0-release.zip
sudo unzip dependency-check-11.1.0-release.zip
sudo rm -rf dependency-check-11.1.0-release.zip
sudo wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
sudo tar -xvzf apache-maven-3.9.9-bin.tar.gz
sudo rm -rf apache-maven-3.9.9-bin.tar.gz
export PATH=$PATH:/opt/apache-maven-3.9.9/bin
sudo wget https://services.gradle.org/distributions/gradle-8.10.1-all.zip
sudo unzip gradle-8.10.1-all.zip
export PATH=$PATH:/opt/gradle-8.10.1/bin
sudo rm -rf unzip gradle-8.10.1-all.zip
sudo wget https://dlcdn.apache.org//ant/binaries/apache-ant-1.10.15-bin.zip
sudo unzip apache-ant-1.10.15-bin.zip
sudo rm -rf apache-ant-1.10.15-bin.zip
cat <<EOF | sudo tee /etc/profile.d/ant.sh
ANT_HOME=/opt/apache-ant-1.10.15
PATH=$ANT_HOME/bin:$PATH
EOF
