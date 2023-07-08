resource "aws_instance" "ubuntu-apache" {
  ami                         = data.aws_ami.ubuntu_latest.id
  instance_type               = "${var.instance_type}"
  vpc_security_group_ids      = [aws_security_group.ubuntu-apache-sg.id]
  key_name                    = var.key-pair
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

resource "aws_security_group" "ubuntu-apache-sg" {
  name = "${var.namespace}-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.namespace}-sg"
  }
}