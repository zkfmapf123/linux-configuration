##########################################################################################################################
### vpc
##########################################################################################################################
resource "aws_vpc" "vpc" {
  cidr_block           = local.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name     = "${local.network_name}-vpc"
    Resource = "vpc"
  }
}

##########################################################################################################################
### igw
##########################################################################################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name     = "${local.network_name}-igw"
    Resource = "igw"
  }
}

##########################################################################################################################
### public subnet Layer 1
##########################################################################################################################
resource "aws_subnet" "public_subnets" {
  for_each = local.publics

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name     = "${local.network_name}-${each.key}-publics"
    Resource = "subnet"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name     = "${local.network_name}-public-rt"
    Resource = "public-route-table"
  }
}

resource "aws_route_table_association" "public_mapping" {
  for_each = aws_subnet.public_subnets

  route_table_id = aws_route_table.public_rt.id
  subnet_id      = each.value.id
}

##########################################################################################################################
### EC2
##########################################################################################################################
#####################################################################
### common
######################################################################
resource "aws_key_pair" "key_pair" {
  key_name   = "linux-pair"
  public_key = file("~/.ssh/id_rsa.pub")
}

######################################################################
### master node
######################################################################
resource "aws_security_group" "linux-sg" {
  name        = "linux-sg"
  description = "linux-sg"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.public_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "linux-sg"
    Resource = "sg"
  }
}

module "linux" {
source = "terraform-aws-modules/ec2-instance/aws"

  name = "linux-instance"

  ami                         = local.ami
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.key_pair.key_name
  availability_zone           = keys(aws_subnet.public_subnets)[0]
  subnet_id                   = values(aws_subnet.public_subnets)[0].id
  vpc_security_group_ids      = [aws_security_group.linux-sg.id]
  monitoring                  = true
  associate_public_ip_address = true

  ebs_block_device = [{
    device_name           = "/dev/sda1"
    volume_size           = "50"
    delete_on_termination = true
  }]

  tags = {
    Name     = "linux-container"
    Resource = "ec2"
  }
}

output public_ip {
    value = module.linux.public_ip
}