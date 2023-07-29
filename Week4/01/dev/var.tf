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