locals {
  domain_name     = "${var.naked_subdomain}${var.naked_domain}"
  domain_name_www = "www.${local.domain_name}"
}
