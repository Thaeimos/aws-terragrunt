resource "aws_organizations_organizational_unit" "this" {
  name      = var.org_unit_name
  parent_id = var.org_id
}