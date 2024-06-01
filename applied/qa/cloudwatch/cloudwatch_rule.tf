terraform {
  source = "../../..//infrastructure/region/cloudwatch"
}

include "root" {
  path = find_in_parent_folders()
}