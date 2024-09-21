data "aws_ami" "ec2_instance" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "description"
    values = ["Amazon Linux 2 *"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "ec2_instance" {
  ami             = coalesce(var.ami, data.aws_ami.ec2_instance.id)
  instance_type   = "t2.micro"
  key_name        = var.key_name
  subnet_id       = var.subnet_id
  security_groups = var.security_groups

  tags = {
    Name = var.name
  }
}