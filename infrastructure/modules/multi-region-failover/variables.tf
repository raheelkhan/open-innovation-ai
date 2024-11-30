variable "name" {
  type = string
}

variable "environment" {
  type        = string
  description = "Environment such as production, staging etc"
}

variable "alb_arn_eu_west_1" {
  type        = string
  description = "ARN of ALB provisioned via AWS ALB Controller in the Ireland region"
}

variable "alb_arn_us_east_1" {
  type        = string
  description = "ARN of ALB provisioned via AWS ALB Controller in the North Virginia region"
}
