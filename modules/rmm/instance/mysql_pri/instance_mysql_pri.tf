
variable "name" {}
variable "azs" {}
variable "ami"  { }
variable "region" { }
variable "instance_type" { }
variable "iam_instance_profile" { } 
variable "subnet_id" { }
variable "volume_id" { }
variable "vpc_security_group_ids" { default = [] }
variable "user_data" { }
variable "count" { default = 1 }
variable "tags" { default = {} }

resource "aws_instance" "ec2_instance_with_iam_profile" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${var.iam_instance_profile}"
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  user_data = "${var.user_data}"
  count = "${var.count}" 
  root_block_devaice = {
    volume_type = "gp2"
    volume_size = "512"
  }
  provisioner "local-exec" {
    command = "aws ec2 attach-volume --region=${var.region} --volume-id=${var.volume_id} --instance-id=${aws_instance.ec2_instance_with_iam_profile} --device=/dev/xvdf"
  }
  provisioner "remote-exec" {
    inline = [
      "while [ ! -e /dev/xvdf ]; do sleep 5; done",
      "echo '/dev/xvdf /data ext4 defaults 0 0' | sudo tee -a /etc/fstab",
      "sudo mkdir -p /var/lib/mysql && sudo mount -t ext4 /dev/xvdf /var/lib/mysql"  
    ]
  }
  tags = "${merge(var.tags, map("Name", "${var.name}"), map("BuiltBy", "Hashicorp-Terraform"))}"
}

output "instance_id" {
  value = "${aws_instance.ec2_instance_with_iam_profile.id}"
}

