
variable "name" { }
variable "path" { default = "/" }
variable "policy" { }
variable "assume_role_policy" { }

resource "aws_iam_role" "assume_role_policy" {
    name = "${var.name}-assume-role-policy"
    path = "${var.path}"
    assume_role_policy = "${var.assume_role_policy}"
}

resource "aws_iam_policy" "policy" {
  name = "${var.name}-policy"
  path = "${var.path}"
  policy = "${var.policy}"
}

resource "aws_iam_policy_attachment" "attach" {
    name = "${var.name}-attachment"
    roles = ["${aws_iam_role.assume_role_policy.name}"]
    policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_iam_instance_profile" "iam_profile" {
  name = "${var.name}-iam-profile"
  roles = [
    "${aws_iam_role.assume_role_policy.name}"
  ]
}

output "iam_profile_id" { value = "${aws_iam_instance_profile.iam_profile.id}" }


