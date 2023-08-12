output "catapp_url" {
  value = {for k, v in aws_instance.hashicat : k => "https:://${v.public_dns}"}
}

output "catapp_ip" {
  value = {for k, v in aws_instance.hashicat : k => "https:://${v.public_ip}"}
}
