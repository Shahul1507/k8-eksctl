
module "workstation" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "workstation"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]
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



resource "aws_security_group" "allow_ssh_terraform" {
    name = "allow_sshh" # allow_ssh is already present in my aws account
    description = "allow port number 22 for SSH access"

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1" # -1 means all
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    ingress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"] # allow from everyone
        ipv6_cidr_blocks = ["::/0"]
    }



    
    tags = {
        Name = "allow_sshh"
    }
}
