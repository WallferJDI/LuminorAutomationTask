variable "environment" {
  type = string
}
variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "kubernetes_version" {
  type = string
}

variable "max_size" {
  type    = number
  default = 2
}
variable "desired_size" {
  type    = number
  default = 1
}
variable "min_size" {
  type    = number
  default = 1
}