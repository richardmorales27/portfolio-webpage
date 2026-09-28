output "website_url" {
  description = "Primary portfolio URL"
  value       = "https://${var.domain_name}"
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.portfolio.domain_name
}

output "s3_bucket_name" {
  description = "Portfolio S3 bucket name"
  value       = aws_s3_bucket.portfolio.bucket
}

output "route53_zone_id" {
  description = "Route 53 hosted zone ID"
  value       = aws_route53_zone.portfolio.zone_id
}