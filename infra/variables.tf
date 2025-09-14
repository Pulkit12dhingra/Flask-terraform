variable "region" {
  type        = string
  default     = "us-east-1"
  description = "region Variable"
}

variable "availablity_zone" {
  type        = string
  default     = "us-east-1a"
  description = "region Variable"
}

variable "vpc_id" {
  type        = string
  default     = "vpc-0e5c9754b9990c224"
  description = " vpc id for the code"
}
variable "image_url" {
  description = "Container image URI (ECR/GHCR)."
  type        = string
  default     = "217262486301.dkr.ecr.us-east-1.amazonaws.com/test_flask/pulkit"
}