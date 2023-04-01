locals {
  cfn = "${var.domain_name}-website-cf"
}

resource "aws_cloudfront_distribution" "root_cloud_front" {
  enabled      = true
  http_version = "http2"

  origin {
    domain_name = aws_s3_bucket.website_bucket.bucket_regional_domain_name # THIS COULD BE WRONG
    origin_id   = local.cfn
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
    }
  }

  default_cache_behavior {
    compress               = true
    target_origin_id       = local.cfn
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      query_string = false
    }
  }

  custom_error_response {
    error_caching_min_ttl = 300
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }

  aliases = [var.domain_name]

#   viewer_certificate {
#     acm_certificate_arn = "" # CERTF ARN HERE
#     ssl_support_method  = "sni-only"
#   }
}
