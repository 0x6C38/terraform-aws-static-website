variable "naked_domain" {
  type        = string
  description = "The naked domain name without www."

  validation {
    condition     = !(substr(var.naked_domain, 0, 4) == "www.")
    error_message = "You must provide the naked domain name without www so that we can redirect one to the other."
  }
}

variable "naked_subdomain" {
  type        = string
  description = "The naked subdomain. It must end with a dot and not contain www."
  default     = ""

  validation {
    condition     = !(substr(var.naked_subdomain, 0, 4) == "www.")
    error_message = "You must provide the naked subdomain name without www so that we can redirect one to the other."
  }

  validation {
    condition     = !(contains(["."], var.naked_subdomain))
    error_message = "The subdomain must end in a dot. For 'subdomain.example.com' simply use 'subdomain.'"
  }
}

locals {
  domain_name = "${var.naked_subdomain}${var.naked_domain}"
  domain_name_www = "www.${local.domain_name}"
}
