
variable "namespace" {
  type = string
  description = "(optional) describe your variable"
  default = "Gril"
}

# List를 사용하여 변수 선언
variable "repository_names" {
  type    = list(string)
  default = ["gril-ecr-a", "gril-ecr-b", "gril-ecr-c"]
}

# Map을 사용하여 변수 선언
variable "repositories" {
  type = map(object({
    scan_on_push = bool
  }))
  default = {
    "gril-ecr-d" = {
      scan_on_push = true
    },
    "gril-ecr-e" = {
      scan_on_push = false
    },
    "gril-ecr-f" = {
      scan_on_push = true
    }
  }
}

# Object을 사용하여 변수 선언
variable "grilserveringress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 8022
      to_port     = 8022
      protocol    = "tcp"
      cidr_blocks = ["100.0.0.0/10"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
# Object을 사용하여 변수 선언
variable "grilserveregress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
