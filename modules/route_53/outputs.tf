# Route 53 output
output "lb_record" {
  value = aws_route53_record.lb_record.name
}