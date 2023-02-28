resource "aws_instance" "ec2_instance" {
  ami           = "ami-08fdec01f5df9998f"
  instance_type = "t2.micro"
  key_name      = "MyDevopsClass"

  subnet_id                   = aws_subnet.devops_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.devops_sg.id]
  associate_public_ip_address = true

  user_data              = file("jenkins.sh")

  tags = {
    "Name" : "Jenkins"
  }
}

resource "aws_ecr_repository" "my_ecr" {
  name = "helloworld" # Replace with your desired repository name
  image_tag_mutability = "MUTABLE" # Optional: Change if you want a different mutability policy

  lifecycle {
    create_before_destroy = true
  }

}
