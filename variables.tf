variable "region" {
  description = "Region for AWS resources"
  type        = string
  default     = "us-east-1"
}

variable "settings" {
  description = "Settings for the RDS"
  type        = map(any)
  default = {
    "tag_default" = {
      "name" = "fiap"
    }
  }
}
