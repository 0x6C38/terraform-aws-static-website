resource "aws_route53_record" "cf_alias_record" {
  zone_id = data.aws_route53_zone.domain_hosted_zone.zone_id
  name    = local.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.root_cloud_front.domain_name
    zone_id                = "Z2FDTNDATAQYW2" # cloudfront
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cf_ipv6_alias_record" {
  zone_id = data.aws_route53_zone.domain_hosted_zone.zone_id
  name    = local.domain_name
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.root_cloud_front.domain_name
    zone_id                = "Z2FDTNDATAQYW2" # cloudfront
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "rcf_alias_record" {
  zone_id = data.aws_route53_zone.domain_hosted_zone.zone_id
  name    = local.domain_name_www
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.redirect_cloud_front.domain_name
    zone_id                = "Z2FDTNDATAQYW2" # cloudfront
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "rcf_ipv6_alias_record" {
  zone_id = data.aws_route53_zone.domain_hosted_zone.zone_id
  name    = local.domain_name_www
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.redirect_cloud_front.domain_name
    zone_id                = "Z2FDTNDATAQYW2" # cloudfront
    evaluate_target_health = false
  }
}
