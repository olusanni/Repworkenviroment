module "developer" {
  source = "../../..//Modules/group"

  groupname                  = "developer-lab"
  region                     = "us-east-1"
  policy_name                = "developer-cloudsentric-managed-policy"
  policy_description         = "cloudsentric-developer-polcy"
  inline_policy_to_attach    = data.aws_iam_policy_document.developer_inline_policy.json
  managed_policies_to_attach = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]


}
data "aws_iam_policy_document" "developer_inline_policy" {
  statement {
    sid = ""
    actions = [
      "cloudtrail:*",
      "cloudwatch:*"
    ]
    resources = ["*"]
  }

  statement {
    sid = ""
    actions = [
      "ec2:*",
      "s3:*"
    ]
    resources = ["*"]
  }
}