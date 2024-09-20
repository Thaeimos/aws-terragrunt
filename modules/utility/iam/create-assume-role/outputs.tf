output "policy_arn" {
  value       = "${aws_iam_policy.assume_role.arn}"
  description = "The ARN of the assume role policy"
}
