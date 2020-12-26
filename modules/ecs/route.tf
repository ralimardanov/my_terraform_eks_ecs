# If you have your own DNS name in AWS Route53, or you are planning to move it there, you can add also Route53 hosted zone/record to point to load balancer.
# I'll save example config here.

/*resource "aws_route53_zone" "stg_hosted_zone" {
  name = lower("${var.common_tags["Env"]}_ecs.com")
}

resource "aws_route53_record" "stg_lb_record" {
  zone_id = aws_route53_zone.stg_hosted_zone.zone_id
  name    = var.route53_name
  type    = var.route53_type

  alias {
    name                   = aws_alb.ecs_load_balancer.dns_name
    zone_id                = aws_alb.ecs_load_balancer.zone_id
    evaluate_target_health = var.route_53_evaluate_value
  }

  depends_on = [ aws_alb.ecs_load_balancer ]
}
*/