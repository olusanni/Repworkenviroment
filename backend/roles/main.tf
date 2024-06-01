resource "aws_iam_role" "Fetch_role" {
  name = "lambda_fetchUnused_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "lambdarole_policy" {
  name = "Lambda_Fetch_Role_policy"
  role = aws_iam_role.Fetch_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:GetRole",
          "iam:DeleteRole",
          "iam:ListRoles",
          "iam:ListRoleTags",
          "sns:Publish",
          "ssm:GetParameter",
          "ssm:GetParameters",
          "config:PutConfigRule",
          "config:PutConfigRuleEvaluationResults",
          "config:DescribeConfigRules",
          "config:GetComplianceDetailsByConfigRule"
    
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}


