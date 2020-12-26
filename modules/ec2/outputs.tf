output "instance_id" {
  value = aws_instance.instance.*.id
}

output "public_ip" {
  value = aws_instance.instance.*.public_ip
}

output "private_ip" {
  value = aws_instance.instance.*.private_ip
}

output "private_key_content" {
  sensitive = true
  value     = join("", tls_private_key.instance_key.*.private_key_pem)
}

/*output "ebs_id" {
  value = aws_instance.instance.*.ebs_block_device.volume_id
}*/