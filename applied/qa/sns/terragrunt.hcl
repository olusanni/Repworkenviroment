terraform {
  source = "../../..//infrastructure/region/sns"
}

include "root" {
  path = find_in_parent_folders()
}