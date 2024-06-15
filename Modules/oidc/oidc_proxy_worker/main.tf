resource "aws_iam_role" "proxy_role" {
  name = var.proxy_role"


  assume_role_policy = <<EOF
{
    "version":"2012-10-17",
    "Statement":[
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Principlal": {
                "Federated": "arn:aws:iam::${var.account_id}:oidc-provider/token.actions.githubusercontent.com"
            },
            "Condition":{
                "StringEquals": {
                    "token.actions.githubusercontent.com:sub:" [
                        "repo:olusanni/${var.github_repo}:pull_request",
                        "repo:olusanni/${var.github_repo}:ref:refs/heads/main"
                    ]
                }
            }
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "proxy_role" {
    name = var.proxy_role_policy
    role = aws_iam_role.proxy_role.id
    policy = <<EOF
{
    "version": "2012-10-17", 
    "Statement": [
        {
            "Effect": "Allow"
            "Action":[
              "sts:AssumeRoleWithWebIdentity",
             "sts:AssumeRole",
             "sts:GetSessionToken",
             "sts:GetFedratedToken"
            ],
            "Resource":[
                "${aws_iam_role.worker_role.arn}"
            ]
            
        }
    ]
}
EOF
}

resource "aws_iam_role" "worker_role" { 
    name = var.worker_role

    assume_role_policy = <<EOF
{
    "version":"2012-10-17",
    "Statement":[
        {
          "Effect": "Allow"
          "Action" : "sts:AssumeRole"
          "Principal":"arn:aws:iam::${var.account_id}:role/${var.proxy_role}"
          "Condition": {}
        }
    ]
}
EOF
}