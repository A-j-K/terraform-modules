
variable "name" { }
variable "ami"  { }
variable "instance_type" { }
variable "subnet_id" { }
variable "vpc_security_group_ids" { default = [] }
variable "user_data" { }
variable "count" { default = 1 }
variable "tags" { default = {} }

resource "aws_instance" "ec2_instance" {
  name = "${var.name}"
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  user_data = "${var.user_data}"
  count = "${var.count}" 
  tags = "${merge(var.tags, 
    map(
      "Name", format("%s.%s", var.name, element(var.azs, count.index)),
      "BuiltBy", "Hashicorp-Terraform"
    ))}"
}

output "instance_id" {
  value = "${aws_instance.ec2_instance.id}"
}

