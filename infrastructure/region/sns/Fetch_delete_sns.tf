module "Fetch_delete_sns" {
  source = "../../..//Modules/sns"

  sns_topic      = "Fetch_deleteNotification"
  region    = "us-east-2"
  notification_email = "sseun01@gmail.com"

}