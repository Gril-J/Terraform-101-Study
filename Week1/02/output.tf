output "ubuntu_apache_ip" {
  value = aws_instance.ubuntu-apache.public_ip
}