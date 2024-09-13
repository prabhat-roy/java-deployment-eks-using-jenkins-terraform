resource "aws_instance" "jenkins-agent" {
  ami             = var.aws_ami
  instance_type   = var.jenkins_agent_instance_type
  subnet_id       = aws_subnet.public_subnet[0].id
  key_name        = var.ssh_key
  security_groups = ["${aws_security_group.jenkins-agent.id}"]
  iam_instance_profile = aws_iam_instance_profile.jenkins_admin_profile.name
  root_block_device {
    volume_size = "20"
    volume_type = "gp3"
    delete_on_termination = true
  }
  tags = {
    Name = "Jenkins-Agent"
  }

}

resource "null_resource" "jenkins-agent" {
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file(var.private_key_path)
    host = aws_instance.jenkins-agent.public_ip
  }
  provisioner "file" {
    source = "jenkins-agent.sh"
    destination = "/tmp/jenkins-agent.sh"
  }
  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/jenkins-agent.sh",
      "/tmp/jenkins-agent.sh",
     ]
  }
}