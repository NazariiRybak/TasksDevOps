# ----------------------------------------------------------
# My Terraform
#
# Building WebServer
#
# Made by Nazar Rybak

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
  tags = {
    Name = "ElasticIP for Terraform instance"
  }
}

resource "aws_vpc" "terraform_vpc" { # vpc
  cidr_block       = var.cidr
  instance_tenancy = "default"
  tags = {
    Name = "terraform-vpc"
  }
}

resource "aws_subnet" "terraform_subnet" { # public subnet
  cidr_block        = var.publicCIDR
  vpc_id            = aws_vpc.terraform_vpc.id
  availability_zone = var.availability_zone

  tags = {
    Name = "terraform-subnet"
  }
}

resource "aws_internet_gateway" "terraform_gateway" { # internet gateway
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "terraform-gateway"
  }
}

resource "aws_route_table" "terraform_route" { # route table
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_gateway.id
  }

  tags = {
    Name = "terraform-route"
  }
}

resource "aws_route_table_association" "terraform-rt-a" { # subnet and routing table association
  subnet_id      = aws_subnet.terraform_subnet.id
  route_table_id = aws_route_table.terraform_route.id
}

resource "aws_instance" "my_webserver" {
  ami                    = var.instance_AMI #Amazon Linux 2023
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("~/Terraform/Playground/user_datash.tpl", {
    f_name = "Nazar",
    l_name = "Rybak",
  })

  tags = {
    Name    = var.instance_tag
    owner   = "Nazar Rybak"
    project = "Demo"
  }
}


resource "aws_security_group" "my_webserver" {
  name        = "Creating security group via TF to Task-1"
  description = "TF WebServer Security Group"

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Group for Terraform instance"
  }
}


