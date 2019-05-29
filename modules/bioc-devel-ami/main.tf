provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "/Users/sdavis2/.aws/credentials"
}

resource "aws_security_group" "rstudio-terraform" {
  name = "rstudio-terraform"

  # rstudio
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
    from_port = 3838
    to_port = 3838
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
  ami = "ami-0a313d6098716f372"
  count = "${var.instance_count}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.rstudio-terraform.id}"]
  root_block_device {
        volume_size = 1000
  }
  user_data = "${file("${path.module}/userdata.sh")}"

  # The name of our SSH keypair you've created and downloaded
  # from the AWS console.
  #
  # https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#KeyPairs:
  #
  key_name = "${var.key_name}"
}

output "public_ips" {
  value = ["${aws_instance.bioc_devel.*.public_ip}"]
}
