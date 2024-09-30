resource "aws_organizations_account" "dev" {

  name  = var.account_name
  email = var.account_email

  # Enables IAM users to access account billing information 
  # if they have the required permissions
  # iam_user_access_to_billing = "ALLOW"

  close_on_deletion = true

  tags = {
    Name  = var.account_name
    # Owner = "Waleed"
    # Role  = "development"
  }

  parent_id = var.org_unit_id
}