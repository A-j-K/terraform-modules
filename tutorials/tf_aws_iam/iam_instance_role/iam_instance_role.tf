
variable "name" { }
variable "path" { default = "/" }
variable "file_policy" { }
variable "file_assume_role_policy" { }

resource "aws_iam_role" "assume_role_policy" {
    name = "${var.name}-assume-role-policy"
    path = "${var.path}"
    assume_role_policy = "${file("${path.module}/${var.file_assume_role_policy}")}"
}

resource "aws_iam_policy" "policy" {
  name = "${var.name}-policy"
  path = "${var.path}"
  policy = "${file("${path.module}/${var.file_policy}")}"
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

output "assume_role_policy_id" { value = "${aws_iam_instance_profile.assume_role_policy.id}" }


