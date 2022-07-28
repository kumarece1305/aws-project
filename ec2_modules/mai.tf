resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id
    ingress {
      description = "ingress_rule_1"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }
   
   ingress {
      description = "ingress_rule_2"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }
   ingress {
      description = "ingress_rule_3"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }
   tags = {
      Name = "new-lab-sg"
   }
}
resource "aws_instance" "ec2" {
  ami         = var.ec2_ami
  instance_type = var.ec2_instance_type
 
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.sg.id]
 
  tags = {
    Name = "staging_ec2"
  }
}
  resource "aws_instance" "db" {
  ami         = var.ec2_ami
  instance_type = var.ec2_instance_type
 
  subnet_id              = var.subnet_id1
  vpc_security_group_ids = [aws_security_group.sg.id]
 
  tags = {
    Name = "ggg-instance"
  }
 
  user_data = <<-EOF
   #!/bin/bash
   sudo yum update -y
   sudo yum install httpd -y
   sudo systemctl enable httpd
   sudo systemctl start httpd
   echo "<html><body><div>This is a test webserver!</div></body></html>" > /var/www/html/index.html
   EOF
}