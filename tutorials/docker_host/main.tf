
resource "aws_instance" "docker_host" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = "${var.vpc_security_group_ids}"
  user_data = "${var.user_data}"
  count = "${var.count}" 
  tag {
    key = "Name"
    value = "${var.name}"
  }
  tag {
    key = "BuiltBy"
    value = "${var.builtby}"
  }
}
