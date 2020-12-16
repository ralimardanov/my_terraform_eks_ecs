data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = var.ami_filter_name   #"name"
    values = var.ami_filter_values #["amzn2-ami-hvm-2.0.20201126.0-arm64-gp2"]
  }

  filter {
    name   = var.ami_virtualization_name   #"virtualization-type"
    values = var.ami_virtualization_values #["hvm"]
  }

  owners = var.ami_owners #["amazon"]
}

resource "tls_private_key" "jenkins_key" {
  algorithm = var.key_algorithm #RSA
  rsa_bits  = var.rsa_bits      #4096
}

resource "aws_key_pair" "jenkins_key_pair" {
  key_name   = var.key_name #jenkins
  public_key = tls_private_key.jenkins_key.public_key_openssh
}

resource "aws_instance" "jenkins" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  security_groups             = var.security_groups
  key_name                    = aws_key_pair.jenkins_key_pair.key_name
  user_data                   = var.user_data
  subnet_id                   = var.subnet_id #"${element(aws_subnet.public_subnets.*.id, 0)}"
  associate_public_ip_address = var.ec2_public_ip

  ebs_block_device {
    device_name           = var.ebs_device_name           #"/dev/xvdf"
    volume_type           = var.ebs_volume_type           #standard
    volume_size           = var.ebs_volume_size           #"20"
    delete_on_termination = var.ebs_delete_on_termination #false    
  }
  tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-SG" })
}
