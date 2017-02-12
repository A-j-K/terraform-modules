output "security_group_id_ssh_only" {
  value = "${aws_security_group.main_security_group.id}"
}

