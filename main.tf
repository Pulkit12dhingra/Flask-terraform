provider "aws" {
  region = var.aws_region
}

# Key Pair for SSH Access
resource "aws_key_pair" "example_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# Security Group for EC2 Instance
resource "aws_security_group" "flask_sg" {
  name        = "flask-sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
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

# EC2 Instance to Host Flask App
resource "aws_instance" "flask_instance" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = var.instance_type
  key_name      = aws_key_pair.example_key.key_name

  # Associate the Security Group
  security_groups = [aws_security_group.flask_sg.name]

  # User Data for Flask App Setup
  user_data = file("${path.module}/scripts/flask_app.sh")

  tags = {
    Name = "FlaskAppInstance"
  }
}

# Output the Public IP of the Instance
output "instance_public_ip" {
  value = aws_instance.flask_instance.public_ip
}
