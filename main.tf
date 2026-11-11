# Mumbai AMI
data "aws_ami" "mumbai" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Sydney AMI
data "aws_ami" "sydney" {
  provider    = aws.sydney
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Default VPC - Mumbai
data "aws_vpc" "mumbai" {
  default = true
}

data "aws_subnets" "mumbai" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.mumbai.id]
  }
}

# Default VPC - Sydney
data "aws_vpc" "sydney" {
  provider = aws.sydney
  default  = true
}

data "aws_subnets" "sydney" {
  provider = aws.sydney

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.sydney.id]
  }
}

# Mumbai Security Group
resource "aws_security_group" "mumbai" {
  name        = "${var.project_name}-mumbai-sg"
  description = "Allow HTTP traffic"
  vpc_id      = data.aws_vpc.mumbai.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Sydney Security Group
resource "aws_security_group" "sydney" {
  provider    = aws.sydney
  name        = "${var.project_name}-sydney-sg"
  description = "Allow HTTP traffic"
  vpc_id      = data.aws_vpc.sydney.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Mumbai EC2
resource "aws_instance" "mumbai" {
  ami                         = data.aws_ami.mumbai.id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnets.mumbai.ids[0]
  vpc_security_group_ids      = [aws_security_group.mumbai.id]
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/user_data.sh", {
    region = "Mumbai"
  })

  user_data_replace_on_change = true

  tags = {
    Name = "${var.project_name}-mumbai"
  }
}

# Sydney EC2
resource "aws_instance" "sydney" {
  provider                    = aws.sydney
  ami                         = data.aws_ami.sydney.id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnets.sydney.ids[0]
  vpc_security_group_ids      = [aws_security_group.sydney.id]
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/user_data.sh", {
    region = "Sydney"
  })

  user_data_replace_on_change = true

  tags = {
    Name = "${var.project_name}-sydney"
  }
}
