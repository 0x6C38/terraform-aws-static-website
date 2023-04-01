variable "domain_name" {
  type        = string
  description = "The naked domain name without www."

  validation {
    condition     = !(substr(var.domain_name, 0, 4) == "www.")
    error_message = "You must provide the naked domain name without www so that we can redirect one to the other."
  }
}
