resource "aws_security_group" "grilsg" {
  vpc_id      = aws_vpc.grilvpc.id
  name        = "${var.namespace} SG"
  description = "${var.namespace} Study SG"
  tags = {
    Name = "${var.namespace}-grilsg"
  }
}

resource "aws_security_group_rule" "grilsginbound" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.grilsg.id
}

resource "aws_security_group_rule" "grilsgoutbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.grilsg.id
}

resource "aws_instance" "grilec2" {

  depends_on = [
    aws_internet_gateway.griligw
  ]

  ami                         = data.aws_ami.gril_amazonlinux2.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.grilsg.id}"]
  subnet_id                   = aws_subnet.grilsubnet1.id

  user_data = <<-EOF
              #!/bin/bash
              wget https://busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-x86_64
              mv busybox-x86_64 busybox
              chmod +x busybox
              RZAZ=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone-id)
              IID=$(curl 169.254.169.254/latest/meta-data/instance-id)
              LIP=$(curl 169.254.169.254/latest/meta-data/local-ipv4)
              echo "<h1>RegionAz($RZAZ) : Instance ID($IID) : Private IP($LIP) : Web Server</h1>" > index.html
              nohup ./busybox httpd -f -p 80 &
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "${var.namespace}-grilec2"
  }
}