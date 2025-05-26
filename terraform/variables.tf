variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type = list(string)
  default = ["eu-north-1a", "eu-north-1b"]
}

variable "github_user" {
  type = string
}

variable "github_token" {
  type      = string
  sensitive = true
}

variable "github_webhook_secret" {
  type      = string
  sensitive = true
}

variable "namespace" {
  type    = string
  default = "atlantis"
}

variable "kubernetes_version" {
  type    = string
  default = "1.29"
}