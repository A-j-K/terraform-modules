
variable "tags" {}

variable "security_group_name" {
  description = "The name for this security group"
}

variable "vpc_id" {
  description = "The VPC this security group will go in"
}

variable "source_cidr_block" {
  description = "The source CIDR block to allow traffic from"
  default = "0.0.0.0/0"
}

resource "aws_security_group" "main_security_group" {
  name = "${var.security_group_name}"
  description = "Security Group ${var.security_group_name}"
  vpc_id = "${var.vpc_id}"
  ingress {
    from_port = 22 
    to_port = 22 
    protocol = "tcp"
    cidr_blocks = ["${var.source_cidr_block}"]
  }
  egress {
    protocol = -1
    from_port = 0
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = "${merge(var.tags, map("Name", "${var.security_group_name}"), map("BuiltBy", "Hashicorp-Terraform"))}"
}


output "security_group_id_ssh_only" {
  value = "${aws_security_group.main_security_group.id}"
}

