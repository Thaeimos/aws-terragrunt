variable "account_name" {
  description = "The name of the account where the new role will be created"
  type        = string
}

variable "assume_role_policy_json" {
  description = "The JSON policy that permits IAM users to assume the new role"
  type        = string
}

variable "role" {
  description = "The name of the new role"
  type        = string
}

variable "role_policy_arn" {
  description = "The ARN of the IAM policy to attach to the new role"
  type        = string
}

variable "tags" {
  description = "Tags to apply to created resources"
  type        = map(string)

  default = {}
}
