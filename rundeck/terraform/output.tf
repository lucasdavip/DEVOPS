output "ipPublic" {
  value = aws_instance.rundeck.public_ip
}

output "dnsPublic" {
  value = aws_instance.rundeck.public_dns
}
