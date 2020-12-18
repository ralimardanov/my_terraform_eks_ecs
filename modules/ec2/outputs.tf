output "instance_id" {
  value = aws_instance.jenkins.*.id
}

output "public_ip" {
  value = aws_instance.jenkins.*.public_ip
}

output "private_ip" {
  value = aws_instance.jenkins.*.private_ip
}

output "private_key_content" {
  sensitive = true
  value     = join("", tls_private_key.jenkins_key.*.private_key_pem)
}

/*output "ebs_id" {
  value = aws_instance.jenkins.*.ebs_block_device.volume_id
}*/