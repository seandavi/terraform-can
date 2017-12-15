provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "/Users/sdavis2/.aws/credentials"
  profile                 = "ec2"
}


variable "jupyter_port" {
  description = "This is the default port on which jupyter is running"
  default = 8888
}

variable "key_name" {
  description = "This is the default port on which jupyter is running"
  default = "CSHLData.2015"
}

resource "aws_security_group" "jupyter" {
  name = "jupyter"

  ingress {
    from_port = "${var.jupyter_port}"
    to_port = "${var.jupyter_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_instance" "ubuntu_deep_learning" {
  count = 1
  ami = "ami-405ade3a"
  instance_type = "t2.small"
  vpc_security_group_ids = ["${aws_security_group.jupyter.id}"]

  tags {
    Name = "ubuntu_deep_learning"
    Use  = "testing"
    Category = "science"
  }

  # The name of our SSH keypair you've created and downloaded
  # from the AWS console.
  #
  # https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#KeyPairs:
  #
  key_name = "${var.key_name}"

}

output "ip" {
  value = "${aws_instance.ubuntu_deep_learning.public_ip}"
}

