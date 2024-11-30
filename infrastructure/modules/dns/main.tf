resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "main" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.global_accelerator_dns_name
    zone_id                = var.global_accelerator_hosted_zone
    evaluate_target_health = true
  }
}
