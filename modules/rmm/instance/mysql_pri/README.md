instance_mysql_pri.tf terraform module
==========================================

A Terraform module to make a basic EC2 instance "suitable" for MySQL.

Input Variables
---------------

- `ami`
- `azs`
- `region`
- `instance_type`
- `iam_instance_profile`
- `subnet_id`
- `volume_id`
- `vpc_security_group_ids`
- `user_data`
- `count
- `tags`

Output Variables
----------------
- `instance_id`


Note
----

* This module reguires an IAM profile.
* This module persists a root_block_device on /var/lib/mysql, supply the volume ID to use.

