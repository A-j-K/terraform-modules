iam_instance_role terraform module
============================

A Terraform module for AWS Instance IAM Profile creation


Input Variables
---------------

- `name` The name of the policy
- `pathi` The path (default "/")
- `policy` The policy to apply
- `assume_role_policy` The assume role policy

Usage
-----

You can use these in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. `main.tf`

```
module "iam_role" {
  source = "ource = "git@github.com:A-j-K/terraform-modules.git//tutorials/tf_aws_iam/iam_instance_role?ref=master"
  name = "${var.name}"
  path = "/"
  policy = "${file("policy.json")}"
  assume_role_policy = "${file("allow.json")}"
}
```

Outputs
-------

- `iam_profile_id` This can be used as the input to an aws_instance.iam_instance_profile variable

Extra Information
-----------------

An example of a policy is:-

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        }
    ]
}
```

An example of an assume policy is:-

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Principal": {
              "Service": ["ec2.amazonaws.com"]
            },
            "Sid": ""
        }
    ]
}
```

For further information see the [http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html](AWS documentation)

