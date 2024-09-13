resource "aws_instance" "jenkins" {
  ami             = var.aws_ami
  instance_type   = var.jenkins_instance_type
  subnet_id       = aws_subnet.public_subnet[0].id
  key_name        = var.ssh_key
  security_groups = ["${aws_security_group.jenkins.id}"]
/*  
#  user_data = file("jenkins.sh")
  
  provisioner "file" {
    source      = "jenkins.sh"
    destination = "/tmp/jenkins.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/jenkins.sh",
      "/tmp/jenkins.sh",
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }

*/
  tags = {
    Name = "Jenkins-Server"
  }
}

resource "null_resource" "jenkins" {
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file(var.private_key_path)
    host = aws_instance.jenkins.public_ip
  }
  provisioner "file" {
    source = "jenkins.sh"
    destination = "/tmp/jenkins.sh"
  }
  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/jenkins.sh",
      "/tmp/jenkins.sh",
     ]
  }
}