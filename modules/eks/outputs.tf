output "eks_cluster_id" {
  value = aws_eks_cluster.eks.id
}
output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}
output "eks_cluster_certificat_authority" {
  value = aws_eks_cluster.eks.certificate_authority
}
output "eks_worker_private_node_id" {
  value = aws_eks_node_group.eks_node_private.id
}
output "eks_worker_public_node_id" {
  value = aws_eks_node_group.eks_node_public.id
}
output "ecr_repo_url" {
  value = aws_ecr_repository.eks_ecr_repo.repository_url
}
output "ecr_dkr_id" {
  value = aws_vpc_endpoint.ecr_dkr.id
}
output "ecr_api_id" {
  value = aws_vpc_endpoint.ecr_api.id
}
output "ecr_ec2_id" {
  value = aws_vpc_endpoint.ec2.id
}
output "ecr_s3_id" {
  value = aws_vpc_endpoint.s3.id
}