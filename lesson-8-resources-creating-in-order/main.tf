provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "my_server_web" {
    ami                    = "ami-0a6dc7529cd559185" # Amazon Linux AMI
    instance_type          = "t3.micro"
    vpc_security_group_ids = [aws_security_group.my_webserver.id]

    tags = {
      Name = "Web server build by Terraform"
    }

    depends_on = [aws_instance.my_server_db]
}

resource "aws_instance" "my_server_app" {
    ami                    = "ami-0a6dc7529cd559185" # Amazon Linux AMI
    instance_type          = "t3.micro"
    vpc_security_group_ids = [aws_security_group.my_webserver.id]

    tags = {
      Name = "App server build by Terraform"
    }

    depends_on = [
      aws_instance.my_server_db, 
      aws_instance.my_server_web
    ]
}

resource "aws_instance" "my_server_db" {
    ami                    = "ami-0a6dc7529cd559185" # Amazon Linux AMI
    instance_type          = "t3.micro"
    vpc_security_group_ids = [aws_security_group.my_webserver.id]

    tags = {
      Name = "DB server build by Terraform"
    }
}

resource "aws_security_group" "my_webserver" {
  name          = "WebServer Security Group"
  description   = "My first security group"

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

  tags  = {
    Name = "Web server security group"
  }
}