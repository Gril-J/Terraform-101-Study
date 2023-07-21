variable "region" {
  type = string
  description = "aws region"
  default     = "ap-northeast-2"
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

variable "gril_tag" {
  type = map(string)
  description = "value of ec2 tag"
  default     = {
    "Owner" = "Gril"
    "Purpose" = "SBX"
    "Environment" = "Dev"
  }
}