provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "/Users/sdavis2/.aws/credentials"
  profile                 = "ec2"
}

resource "aws_security_group" "mongo-terraform" {
  name = "mongo-terraform"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # shiny server
  ingress {
    from_port = 27017
    to_port = 27017
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # all output
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

output "image_id" {
    value = "${data.aws_ami.ubuntu.id}"
}

resource "aws_instance" "aws" {
  ami           = "${data.aws_ami.ubuntu.id}"
  count = "1"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.mongo-terraform.id}"]
  root_block_device {
        volume_size = 100
  }
  user_data = "${file("${path.module}/userdata.sh")}"
  tags {
    Name = "${var.instance_name}-${count.index}"
    Use  = "daily_work"
    Category = "science"
    App = "mongodb"
  }

  # The name of our SSH keypair you've created and downloaded
  # from the AWS console.
  #
  # https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#KeyPairs:
  #
  key_name = "${var.key_name}"
}

output "public_ips" {
  value = ["${aws_instance.aws.*.public_ip}"]
}
