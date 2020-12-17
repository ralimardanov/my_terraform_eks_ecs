# Network outputs
output "vpc_id" {
  value = module.network.vpc_id
}
output "vpc_cidr" {
  value = module.network.vpc_cidr
}
output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}
output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}

# SG outputs
output "sg_module_id" {
  value = module.security_groups.sg_id
}

# EC2 outputs
output "instance_id" {
  value = module.ec2.instance_id
}
output "public_ip" {
  value = module.ec2.public_ip
}
output "private_ip" {
  value = module.ec2.private_ip
}

output "private_key_content" {
  value = module.ec2.private_key_content
}

/*output "ebs_id" {
  value = module.ec2.ebs_id
}*/