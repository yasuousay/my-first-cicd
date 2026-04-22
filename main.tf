# 1. Khai báo AWS Region (Không còn Access Key ở đây nữa)
provider "aws" {
  region = "ap-southeast-1"
}

# 2. Dùng Data block để nhờ Terraform tự động tìm ID của hệ điều hành Ubuntu 22.04 mới nhất
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # ID chính thức của Canonical (nhà sản xuất Ubuntu)
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# 3. Tạo Security Group (Anh bảo vệ) mở Cửa 80 và 22
resource "aws_security_group" "web_sg" {
  name        = "terraform-web-sg"
  description = "Cho phep HTTP va SSH"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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

# 4. Tạo máy chủ EC2 (Thuê t3.micro cho Free Tier)
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro" 
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # Phép màu ở đây: Tự động chạy script khi máy chủ vừa khởi động xong
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              echo "<h1>May chu nay duoc tao tu dong bang Terraform!</h1>" > /var/www/html/index.html
              sudo systemctl restart nginx
              EOF

  tags = {
    Name = "Terraform-WebServer"
  }
}

# 5. In ra cái Public IP để chúng ta đỡ phải vào web AWS copy
output "public_ip" {
  value = aws_instance.web_server.public_ip
}
