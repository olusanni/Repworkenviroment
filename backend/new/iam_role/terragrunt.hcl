terraform {
  source = "../../..//infrastructure/region/iam_role"
}

include "root" {
  path = find_in_parent_folders()
}