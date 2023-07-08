variable "region" {
  type = string
  description = "aws region"
  default     = "ap-northeast-2"
}

variable "namespace" {
  type = string
  description = "(optional) describe your variable"
  default = "Gril"
}

variable "instance_type" {
  type = string
  description = "instance type"
  default     = "t3.large"
}

variable "key-pair" {
  type = string
  description = "ec2 key pair"
  default     = "terraform"
}