output "name" {
  value       = "${aws_iam_role.role.name}"
  description = "The name of the role"
}
