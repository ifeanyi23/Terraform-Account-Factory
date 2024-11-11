variable "aws_region" {
  description = "The AWS region."
  type        = string
  default     = "ap-southeast-2"

  validation {
    condition     = contains(["ap-southeast-2"], var.aws_region)
    error_message = "Variable 'aws_region' must be a permitted AWS Region."
  }
}

variable "aws_account_id" {
  description = "The ID of the AWS Account."
  type        = string

  validation {
    condition     = can(regex("^\\d{12}$", var.aws_account_id))
    error_message = "Variable 'aws_account_id' must be a string with exactly 12 numbers."
  }
}

variable "environment" {
  description = "Distinguish between development, test, and production resources. Valid options are `sandbox`, `dev`, `sit`, `uat`, `ppe`, and `prod`."
  type        = string

  validation {
    condition     = contains(["sandbox", "dev", "sit", "uat", "ppe", "prod"], var.environment)
    error_message = "Variable 'environment' must be `sandbox`, `dev`, `sit`, `uat`, `ppe`, or `prod`."
  }
}