variable  "config_rule" {
    description = "the name of the config rule to be created"
    type = string
}

variable  "max_credential_usage_age" {
    description = "the name of the maximum credential used age to be created"
    type = string
    default = "11"
}

variable "region" {
    type = string
}
