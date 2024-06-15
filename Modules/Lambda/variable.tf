variable  "Lambdafunction_name" {
    description = "the name of the lamda funtion to be created"
    type = string
}

variable  "iam_role" {
    description = "the name of the iam role to be created"
    type = string
}

variable  "policy_name" {
    description = "the name of the policy to be created"
    type = string
}

variable "cloudwatch_rule" {
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
