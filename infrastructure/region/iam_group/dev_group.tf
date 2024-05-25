module "dev" {
  source = "../../..//Modules/group"

  groupname                  = "dev-lab"
  region                     = "us-east-1"
  policy_name                = "dev-cloudsentric-managed-policy"
  policy_description         = "cloudsentric-dev-polcy"
  inline_policy_to_attach    = data.aws_iam_policy_document.dev_inline_policy.json
  managed_policies_to_attach = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    ]


}
data "aws_iam_policy_document" "dev_inline_policy" {
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