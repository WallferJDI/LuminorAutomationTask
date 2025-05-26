variable "namespace" {
  type    = string
  default = "atlantis"
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

variable "environment" {
  type = string
}

