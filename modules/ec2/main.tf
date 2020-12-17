# AWS_AMI configuration for instance
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = var.ami_filter_name   
    values = var.ami_filter_values 
  }

  filter {
    name   = var.ami_virtualization_name   
    values = var.ami_virtualization_values 
  }

  owners = var.ami_owners
}

# SSH key generation for instance
resource "tls_private_key" "jenkins_key" {
  algorithm = var.key_algorithm
  rsa_bits  = var.rsa_bits      
}

resource "aws_key_pair" "jenkins_key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.jenkins_key.public_key_openssh
}

# EC2 instance configuration
resource "aws_instance" "jenkins" {
  count                       = var.instance_count
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  security_groups             = var.security_groups
  key_name                    = aws_key_pair.jenkins_key_pair.key_name
  user_data                   = var.user_data
  subnet_id                   = var.subnet_id 
  associate_public_ip_address = var.ec2_public_ip

  ebs_block_device {
    device_name           = var.ebs_device_name           
    volume_type           = var.ebs_volume_type           
    volume_size           = var.ebs_volume_size           
    delete_on_termination = var.ebs_delete_on_termination  
  }

  # Always first create, then destroy instance
  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-SG" })
}