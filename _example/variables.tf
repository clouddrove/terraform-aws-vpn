#Module      : LABEL
#Description : Terraform label module variables.

variable "environment" {
  type        = string
  default     = "test"
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}