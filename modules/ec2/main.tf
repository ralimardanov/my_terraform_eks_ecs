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

# EC2 instance profile, pocily and role configuration
# You can create your policy, using json format. I've attached AWS managed policy for SSM for now.
data "aws_iam_policy" "ssm_access" {
  arn = var.aws_iam_policy_arn
}

data "aws_iam_policy_document" "ssm_access" {
  statement {
    actions = var.iam_policy_document_actions

    principals {
      type        = var.iam_policy_document_type
      identifiers = var.iam_policy_document_identifiers
    }
  }
}
resource "aws_iam_role" "ssm_role" {
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.ssm_access.json
}
resource "aws_iam_role_policy_attachment" "ssm_role_ssm_access_policy_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = data.aws_iam_policy.ssm_access.arn
}
resource "aws_iam_instance_profile" "ssm_access" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.ssm_role.name
}

# SSH key generation for instance
resource "tls_private_key" "instance_key" {
  algorithm = var.key_algorithm
  rsa_bits  = var.rsa_bits
}

resource "aws_key_pair" "instance_key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.instance_key.public_key_openssh
}

# EC2 instance configuration
resource "aws_instance" "instance" {
  count                       = var.instance_count
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  security_groups             = var.security_groups
  key_name                    = aws_key_pair.instance_key_pair.key_name
  user_data                   = var.user_data
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.ec2_public_ip
  iam_instance_profile        = aws_iam_instance_profile.ssm_access.name

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

  tags = merge(var.common_tags, { Name = "${var.common_tags["Env"]}-${var.instance_name}-Instance" })
}