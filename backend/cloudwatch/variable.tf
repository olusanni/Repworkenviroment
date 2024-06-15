variable "cloudwatch_rule" {
    description = "name to be given to cloud watch rule"
    type = string
    default = null
}

variable "lambda_function_name" {
    description = "the name of lamda function to allow cloudwatch to invoke"
    type = string
}

variable "schedule_expression" {
    description = "the name given to the schedule expression"
    type = string
    default = null
}

variable "region" {
    type = string
}

