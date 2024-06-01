module "it_engineer" {
  source = "../../..//Modules/group"

  groupname                  = "it_engineer-lab"
  region                     = "us-east-2"
  policy_name                = "it_engineer-cloudsentric-managed-policy"
  policy_description         = "cloudsentric-it_engineer-polcy"
  inline_policy_to_attach    = data.aws_iam_policy_document.it_engineer_inline_policy.json
  managed_policies_to_attach = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]


}
data "aws_iam_policy_document" "it_engineer_inline_policy" {
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