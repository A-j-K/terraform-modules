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
}

