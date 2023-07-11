output "aws_vpc_id" {
  value = aws_vpc.grilvpc.id
}

output "grilec2_public_ip" {
  value       = aws_instance.grilec2.public_ip
  description = "The public IP of the Instance"
}

