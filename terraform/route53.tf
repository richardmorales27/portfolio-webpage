resource "aws_route53_zone" "portfolio" {
  name = var.domain_name

  tags = {
    Name    = "Portfolio Hosted Zone"
    Project = "Portfolio"
  }
}

resource "aws_route53_record" "certificate_validation" {
  for_each = toset([
    var.domain_name,
    var.www_domain_name
  ])

  zone_id = aws_route53_zone.portfolio.zone_id

  name = [
    for option in aws_acm_certificate.portfolio.domain_validation_options :
    option.resource_record_name
    if option.domain_name == each.key
  ][0]

  type = [
    for option in aws_acm_certificate.portfolio.domain_validation_options :
    option.resource_record_type
    if option.domain_name == each.key
  ][0]

  records = [
    [
      for option in aws_acm_certificate.portfolio.domain_validation_options :
      option.resource_record_value
      if option.domain_name == each.key
    ][0]
  ]

  ttl = 60
}

resource "aws_acm_certificate_validation" "portfolio" {
  certificate_arn = aws_acm_certificate.portfolio.arn

  validation_record_fqdns = [
    for record in aws_route53_record.certificate_validation :
    record.fqdn
  ]
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.portfolio.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.portfolio.domain_name
    zone_id                = aws_cloudfront_distribution.portfolio.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.portfolio.zone_id
  name    = var.www_domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.portfolio.domain_name
    zone_id                = aws_cloudfront_distribution.portfolio.hosted_zone_id
    evaluate_target_health = false
  }
}