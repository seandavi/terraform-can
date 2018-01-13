provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "/Users/sdavis2/.aws/credentials"
  profile                 = "ec2"
}

resource "aws_security_group" "rstudio" {
  name = "rstudio"

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

  # all output
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}


resource "aws_instance" "bioc_devel" {
  count = 1
  ami = "ami-e3883599"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.rstudio.id}"]
  user_data = "${file("userdata.sh")}"
  tags {
    Name = "bioc_devel_ami"
    Use  = "daily_work"
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
  value = "${aws_instance.bioc_devel.public_ip}"
}

