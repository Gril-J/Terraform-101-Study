variable "region" {
  type = string
  description = "aws first region"
  default     = "ap-northeast-2"
}

variable "second_region"{
  type = string
  description = "aws second region"
  default     = "ap-northeast-1"
}

variable "namespace" {
  type = string
  description = "(optional) describe your variable"
  default = "Gril2"
}

variable "instance_type" {
  type = string
  description = "instance type"
  default     = "t3.micro"
}

variable "key-pair" {
  type = string
  description = "ec2 key pair"
  default     = "terraform"
}
