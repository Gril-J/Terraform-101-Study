variable "azs" {
  type = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnets"
  default     = ["100.10.1.0/24", "100.10.3.0/24", "100.10.5.0/24"]
}


variable "private_subnets" {
  type        = list(string)
  description = "List of public subnets"
  default     = ["100.10.2.0/24", "100.10.4.0/24", "100.10.6.0/24"]
}


variable "vpc_tag" {
  type = map(string)
  description = "value of ec2 tag"
  default     = {
    "Owner" = "Gril"
    "Purpose" = "SBX"
    "Environment" = "Dev"
  }
}