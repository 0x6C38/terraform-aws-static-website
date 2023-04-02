output "cf_domain_name" {
  value       = aws_cloudfront_distribution.root_cloud_front.domain_name
  description = "Cloud front root distribution domain name."
}

output "rcf_domain_name" {
  value       = aws_cloudfront_distribution.redirect_cloud_front.domain_name
  description = "Redirect cloud front root distribution domain name."
}

output "upload_command" {
  value       = "aws s3 sync website/ s3://${aws_s3_bucket.website_bucket.bucket} --delete && aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.root_cloud_front.id} --paths '/*' && aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.redirect_cloud_front.id} --paths '/*'"
  description = "Command to deploy. Syncs objects to s3 and then invalidates the cloudfront cache."
}
