module "itsupport_prod" {
  source = "../../..//Modules/group"

  groupname                  = "itsupport_prod-lab"
  region                     = "us-east-1"
  policy_name                = "itsupport_prod-cloudsentric-managed-policy"
  policy_description         = "cloudsentric-itsupport_prod-polcy"
  inline_policy_to_attach    = data.aws_iam_policy_document.itsupport_prod_inline_policy.json
  managed_policies_to_attach = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    ]


}
data "aws_iam_policy_document" "itsupport_prod_inline_policy" {
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