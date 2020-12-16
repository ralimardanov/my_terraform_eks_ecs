output "instance_id" {
  value = aws_instance.jenkins.id
}

output "public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "private_ip" {
  value = aws_instance.jenkins.private_ip
}

output "ebs_id" {
  value = aws_instance.jenkins.ebs_block_device.0.volume_id
}