output "public_ip" {
  description = "Show Public IP address"
  value       = aws_eip.my_static_ip.public_ip
}

output "ec2_ami" {
  description = "Show AMI ID"
  value       = aws_instance.my_webserver.ami
}

output "ec2_type" {
  value = aws_instance.my_webserver.instance_type
}

output "public_vpc_id" {
  value = aws_vpc.terraform_vpc.id
}

output "ec2_subnet_id" {
  value = aws_instance.my_webserver.subnet_id
}

output "public_subnet_AZ" {
  value = aws_subnet.terraform_subnet.availability_zone
}

output "ec2_region" {
  value = var.region
}


