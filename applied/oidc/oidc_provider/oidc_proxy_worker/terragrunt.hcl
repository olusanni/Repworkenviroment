terraform {
  source = "../../../..//modules/oidc/oidc_proxy_worker"
}

include "root" {
  path = find_in_parent_folders()
}