
variable "azs" {}
variable "ami"  { }
variable "instance_type" { }
variable "iam_instance_profile" { } 
variable "subnet_id" { }
variable "vpc_security_group_ids" { default = [] }
variable "user_data" { }
variable "count" { default = 1 }
variable "tags" { default = {} }
variable "default_tags" { 
  type = "map"
  default = {
    "BuiltBy" = "Hashicorp-Terraform" 
  } 
}

resource "aws_instance" "ec2_instance_with_iam_profile" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${var.iam_instance_profile}"
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  user_data = "${var.user_data}"
  count = "${var.count}" 
  tags = "${merge(var.tags, map("Name", "${var.name}"), map("BuiltBy", "Hashicorp-Terraform"))}"
}

output "instance_id" {
  value = "${aws_instance.ec2_instance_with_iam_profile.id}"
}

