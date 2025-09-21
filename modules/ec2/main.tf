data "aws_ami" "amazon_linux_2025" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*"]
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
    name   = "architecture"
    values = ["x86_64"]   # 👈 ensure Intel/AMD AMI
  }

  owners = ["137112412989"]
}

# Public EC2 instance
resource "aws_instance" "public_instance" {
  ami           = data.aws_ami.amazon_linux_2025.id
  instance_type = var.instance_type
  tags = {
    Name = "public-instance"
    env  = "prod"
  }
}