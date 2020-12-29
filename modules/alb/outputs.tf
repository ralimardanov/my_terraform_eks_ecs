output "load_balancer_dns_name" {
  value = aws_alb.load_balancer.dns_name
}
output "load_balancer_zone_id" {
  value = aws_alb.load_balancer.zone_id
}
output "target_group_arn" {
  value = aws_alb_target_group.target_group.arn
}