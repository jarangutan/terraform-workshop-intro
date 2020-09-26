variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region to use in AWS"
}

variable "env" {
  type        = string
  default     = "dev"
  description = "Environment prefix for resources"
}
