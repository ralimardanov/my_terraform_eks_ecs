# If you have your own DNS name in AWS Route53, or you are planning to move it there, you can add also Route53 hosted zone/record to point to load balancer.
# I'll save example config here.

resource "aws_route53_zone" "hosted_zone" {
  name = lower("${var.common_tags["Env"]}_${var.common_tags["Component"]}.com")
}

resource "aws_route53_record" "lb_record" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name    = var.route_53_name
  type    = var.route_53_type

  alias {
    name                   = var.load_balancer_dns_name
    zone_id                = var.load_balancer_zone_id
    evaluate_target_health = var.route_53_evaluate_value
  }
}