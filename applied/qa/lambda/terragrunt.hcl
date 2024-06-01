terraform {
  source = "../../..//infrastructure/region/lambda"
}

include "root" {
  path = find_in_parent_folders()
}