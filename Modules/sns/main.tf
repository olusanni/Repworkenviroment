resource "aws_sns_topic" "Fetch_delete" {
  name = var.sns_topic
}
resource "aws_sns_topic_subscription" "subscribe_email" {
  topic_arn = aws_sns_topic.Fetch_delete.arn
  protocol  = "email"
  endpoint  = var.notification_email
}