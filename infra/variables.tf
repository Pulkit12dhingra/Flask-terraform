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

variable "project_name" {
  type    = string
  default = "py-ecs"
}
variable "image_url" {
  description = "Container image URI (ECR/GHCR)."
  type        = string
  default     = "217262486301.dkr.ecr.us-east-1.amazonaws.com/test_flask/pulkit"
}
variable "app_name" {
  description = "Application name (used in resource names)."
  type        = string
  default     = "flask-app"
}

variable "container_port" {
  type        = number
  default     = 5000
}

variable "desired_count" {
  type        = number
  default     = 1
}

variable "cpu" {
  type        = number
  default     = 256
}

variable "memory" {
  type        = number
  default     = 512
}