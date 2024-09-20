output "role_name" {
  value       = "${module.create_role.name}"
  description = "The name of the role"
}

output "policy_arn" {
  value       = "${module.assume_role.policy_arn}"
  description = "The ARN of the assume role policy"
}
