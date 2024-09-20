output "organisation_admin_role_policy_arn" {
  value       = "${module.assume_role_organisation_admin.policy_arn}"
  description = "The ARN of the Administrator role policy for the Organisation"
}
