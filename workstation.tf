
module "workstation" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "workstation"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [var.sg_id]
  # convert StringList to list and get first element
  subnet_id = var.public_subnet_id
  ami = data.aws_ami.ami_info.id
    root_block_device = [
    {
      volume_size           = 50
      volume_type           = "gp3"
      delete_on_termination = true
    }
  ]
  user_data = file("workstation.sh")
  tags = {
        Name = "workstation"
    }
}




