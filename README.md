# Terraform Static Website Module on AWS
This repository defines a terraform module for hosting a static website on AWS. The website is served using an S3 bucket and cached using cloudfront. This approach doesn't require any servers and can handle millions of users without a problem.

## Architecture
The resources defined in this module include:

* 2 S3 Buckets (1 for the static files, 1 for redirecting `.www`)
* 2 Cloudfront Distributions (1 for the root domain, 1 for redirecting `.www`)
* DNS `A` and `AAAA` records from the root domain and the www domain to cloudfront
* An ACM ssl certificate issued for the apex domain provided and subdomains
* DNS `CNAME` records for automatic verification of the ssl certificate

## Requirements
* Terraform
* AWS credentials setup
* A domain registered on AWS

## Usage
Include this module in your configuration:

```hcl
module "website" {
  source       = "github.com/0x6C38/tf-aws-static-website"
  naked_domain = "example.com"
}
```
The domain name provided must not include "www". Alternatively you can also provide a subdomain that must end in a dot:

```hcl
module "website" {
  source       = "../s3-cf-tf-static-website/"
  
  # Will be hosted at subdomain.example.com
  naked_domain = "example.com"
  naked_subdomain = "subdomain."
}
```

Once all the resources have been provisioned you can upload your static website files to s3 and invalidate the cf cache using the "upload_command" output that should have the following format:

```bash
aws s3 sync PATH_TO_WEBSITE_FILES/ s3://example-bucket-website --delete && aws cloudfront create-invalidation --distribution-id ZZZZZZZZZZZZ --paths '/*' && aws cloudfront create-invalidation --distribution-id XXXXXXXXXXXX --paths '/*'
```

## Outputs
The following outputs are available:

* `upload_command`: The aws cli command to sync s3 and invalidate cloudfront caches.
* `empty_bucket_command`: The command used empty the bucket website bucket.
* `domain_name`: The website url.
* `cf_domain_name`: The cloudfront domain name.
* `rcf_domain_name`: The cloudfront redirect domain.
* `s3_website_endpoint`: The S3 endpoint where the website is hosted.
* `s3_redirect_endpoint`: The S3 endpoint for the redirect bucket.

In the newer versions of terraform, outputs from modules are only accesible if you re-export them. For example:

```hlc
output "upload_command" {
  value = module.website.upload_command
}
```

## Cleanup
Empty the website bucket (you can use the `empty_bucket_command` output) and then run `terraform destroy` as usual.