terraform {
  source = "../../..//infrastructure/region/ssm"
}

include "root" {
  path = find_in_parent_folders()
}