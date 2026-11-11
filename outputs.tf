output "mumbai_public_ip" {
  value = aws_instance.mumbai.public_ip
}

output "mumbai_nginx_url" {
  value = "http://${aws_instance.mumbai.public_ip}"
}

output "sydney_public_ip" {
  value = aws_instance.sydney.public_ip
}

output "sydney_nginx_url" {
  value = "http://${aws_instance.sydney.public_ip}"
}
