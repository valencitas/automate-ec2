
# initialises a basic instance with AL2 AMI

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  user_data     = data.template_file.user_data.rendered

  vpc_security_group_ids = [aws_security_group.automate_ec2.id]

  tags = {
    "Environment" = var.environment_tag
  }
}

# Add scripts to instance with cloud config
data "template_file" "user_data" {
  template = file("cloudinit.tpl")

  vars ={
    resource_checker = base64encode(data.template_file.resource_checker.rendered)
    count_words      = base64encode(data.template_file.count_words.rendered)
  }
}

data "template_file" "count_words" {
  template = file("count_words.py")
}

data "template_file" "resource_checker" {
  template = file("resource_checker.sh")
}