
variable "name" { default = "docker-host" }
variable "ami"  { }
variable "instance_type" { }
variable "subnet_id" { }
variable "vpc_security_group_ids" { }
variable "user_data" { }
variable "count" { default = 1 }
variable "builtby" { default = "Hashicorp-Terraform" }

