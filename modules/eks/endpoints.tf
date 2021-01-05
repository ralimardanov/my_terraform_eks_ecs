# This is Interface/Gateway endpoint configuration, which will allow communication between instances in our VPC. 
# Worker nodes in private subnet will need access to other AWS services apart from EKS control plane: ECR, EC2, S3.
resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = var.eks_vpc_id
  service_name        = var.eks_ecr_service_name     
  vpc_endpoint_type   = var.eks_vpc_endpoint_type_int 
  private_dns_enabled = var.eks_private_dns_enabled   
  subnet_ids          = var.eks_subnet_ids          

  security_group_ids = var.eks_ecr_security_group_ids

  tags = merge(var.eks_common_tags, { Name = "${var.eks_common_tags["Env"]}-${var.eks_common_tags["Component"]}-ECR-DKR-END" })
}
resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = var.eks_vpc_id
  service_name        = var.eks_ecr_api_service_name  
  vpc_endpoint_type   = var.eks_vpc_endpoint_type_int
  private_dns_enabled = var.eks_private_dns_enabled
  subnet_ids          = var.eks_subnet_ids 

  security_group_ids = var.eks_ecr_security_group_ids

  tags = merge(var.eks_common_tags, { Name = "${var.eks_common_tags["Env"]}-${var.eks_common_tags["Component"]}-ECR-API-END" })
}
resource "aws_vpc_endpoint" "ec2" {
  vpc_id              = var.eks_vpc_id
  service_name        = var.eks_ec2_service_name    
  vpc_endpoint_type   = var.eks_vpc_endpoint_type_int 
  private_dns_enabled = var.eks_private_dns_enabled  
  subnet_ids          = var.eks_ec2_subnet_ids     

  security_group_ids = var.eks_ec2_security_group_ids

  tags = merge(var.eks_common_tags, { Name = "${var.eks_common_tags["Env"]}-${var.eks_common_tags["Component"]}-EC2-END" })
}
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.eks_vpc_id
  service_name      = var.eks_s3_service_name       
  vpc_endpoint_type = var.eks_vpc_endpoint_type_gtw 
  route_table_ids   = var.eks_s3_route_table_ids  

  tags = merge(var.eks_common_tags, { Name = "${var.eks_common_tags["Env"]}-${var.eks_common_tags["Component"]}-S3-END" })
}