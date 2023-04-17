output "s3_redirect_endpoint" {
  value       = aws_s3_bucket_website_configuration.redirect_bucket_website_config.website_endpoint
  description = "S3 redirect endpoint."
}

output "s3_website_endpoint" {
  value       = aws_s3_bucket_website_configuration.bucket_website_config.website_endpoint
  description = "S3 website endpoint."
}

output "cf_domain_name" {
  value       = aws_cloudfront_distribution.root_cloud_front.domain_name
  description = "Cloud front root distribution domain name."
}

output "rcf_domain_name" {
  value       = aws_cloudfront_distribution.redirect_cloud_front.domain_name
  description = "Redirect cloud front root distribution domain name."
}

output "domain_name" {
  value       = local.domain_name
  description = "The domain name where the website is hosted."
}

output "upload_command" {
  value       = "aws s3 sync website/ s3://${aws_s3_bucket.website_bucket.bucket} --delete && aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.root_cloud_front.id} --paths '/*' && aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.redirect_cloud_front.id} --paths '/*'"
  description = "Command to deploy. Syncs objects to s3 and then invalidates the cloudfront cache."
}

output "empty_bucket_command" {
  value       = "aws s3 rm s3://${aws_s3_bucket.website_bucket.bucket} --recursive"
  description = "Command to empty the bucket used to host the website."
}
