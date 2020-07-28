resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Environment = var.environment_tag
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Environment = var.environment_tag
  }
}

resource "aws_subnet" "subnet_public" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_subnet
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone
  tags = {
    Environment = var.environment_tag
  }
}

resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Environment = var.environment_tag
  }
}

resource "aws_route_table_association" "route_table_association_subnet_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.route_table_public.id
}

# allow traffic in from https
resource "aws_security_group" "automate_ec2" {
  name = "automate-ec2"
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Environment" = var.environment_tag
  }
}

resource "aws_security_group_rule" "allow_https_in" {
  security_group_id = aws_security_group.automate_ec2.id
  
  type = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  description = "https in to instance"  
}

# rule to allow ssh access for debugging
# resource "aws_security_group_rule" "allow_ssh_in" {
#   security_group_id = aws_security_group.automate_ec2.id
  
#   type        = "ingress"
#   from_port   = 22
#   to_port     = 22
#   protocol    = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]

#   description = "ssh in to instance for debugging purposes"  
# }


