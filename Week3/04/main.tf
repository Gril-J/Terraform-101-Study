data "aws_ami" "ubuntu_latest" {
  most_recent = true 
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] 
}
resource "aws_instance" "ubuntu-apache" {
  count                       = 2
  ami                         = data.aws_ami.ubuntu_latest.id
  instance_type               = "${var.instance_type}"
  key_name                    = var.key-pair == "terraform" ? var.key-pair : ""
  associate_public_ip_address = true
  user_data = <<-EOF
            #!/bin/bash
            sleep 60
            sudo apt-get -y update
            sudo apt-get -y install apache2
            sudo service apache2 start
            echo "Hello, Gril" > /var/www/html/index.html
            EOF
  tags = merge(var.gril_tag,
  {
    "Name" = format("%s-%s", var.namespace, "-ubuntu-apache${count.index + 1}")
  })
} 

resource "terraform_data" "null" {
  triggers_replace = [
    aws_instance.ubuntu-apache[0].id,
    aws_instance.ubuntu-apache[1].id
  ]
  input = "Terraform_Data"
}

output "terraform_data" {
  value = terraform_data.null.output
}