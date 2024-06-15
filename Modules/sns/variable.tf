variable  "sns_topic" {
    description = "the name of the SNS topic"
    type = string
}

variable  "notification_email" {
    description = "the email address to send notification to"
    type = string
}

variable "region" {
    type = string
}
