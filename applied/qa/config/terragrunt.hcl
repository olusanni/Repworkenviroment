terraform {
  source = "../../..//infrastructure/region/config"
}

include "root" {
  path = find_in_parent_folders()
}