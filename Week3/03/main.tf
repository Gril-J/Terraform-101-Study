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

resource "aws_security_group" "ubuntu-apache-sg" {
  name = "${var.namespace}-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "ubuntu-apache" {
  ami                         = data.aws_ami.ubuntu_latest.id
  instance_type               = "${var.instance_type}"
  vpc_security_group_ids      = ["${aws_security_group.ubuntu-apache-sg.id}"]
  key_name                    = var.key-pair == "terraform" ? var.key-pair : ""
  associate_public_ip_address = true
  tags = merge(var.gril_tag,
  {
    "Name" = format("%s-%s", var.namespace, "-ubuntu-apache")
  })
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("${path.module}/terraform.pem")
    host     = aws_instance.ubuntu-apache.public_ip
  }

  provisioner "file" {
    source      = "script.sh"
    destination = "/home/ubuntu/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/script.sh",
      "sudo /home/ubuntu/script.sh",
    ]
  }
} 


