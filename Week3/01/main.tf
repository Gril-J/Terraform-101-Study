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
  tags = { Name = "${var.namespace}-ubuntu-apache" }
}