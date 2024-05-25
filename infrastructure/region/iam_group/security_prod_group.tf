module "security_Prod" {
  source = "../../..//Modules/group"

  groupname                  = "security_Prod-lab"
  region                     = "us-east-1"
  policy_name                = "security_ProdProd-cloudsentric-managed-policy"
  policy_description         = "cloudsentric-security_Prod-polcy"
  inline_policy_to_attach    = data.aws_iam_policy_document.security_Prod_inline_policy.json
  managed_policies_to_attach = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    ]


}
data "aws_iam_policy_document" "security_Prod_inline_policy" {
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