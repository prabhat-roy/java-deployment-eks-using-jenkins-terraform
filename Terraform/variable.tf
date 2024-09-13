variable "aws_region" {
  type = string
}

variable "aws_vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
}

variable "Worker_node_instance_type" {
  type = string
}

variable "jenkins_instance_type" {
  type = string
}

variable "jenkins_agent_instance_type" {
  type = string
}

variable "nexus_instance_type" {
  type = string
}

variable "sonarqube_instance_type" {
  type = string
}

variable "tomcat_instance_type" {
  type = string
}
variable "ssh_key" {
  type = string
}

variable "aws_ami" {
  type = string
}

variable "private_key_path" {
  type = string
}