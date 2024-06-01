variable "cloudwatch-rule" {
    description = "name to be given to cloud watch rule"
    type = string
    default = null
}

variable "schedule_expression" {
    description = "the name given to the schedule expression"
    type = string
    default = null
}

variable "region" {
    type = string
}

