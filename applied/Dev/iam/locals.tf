locals {
  Team = {
    "Bisi2"  = "arn:aws:iam::aws:policy/ReadOnlyAccess",
    "Dada12" = "arn:aws:iam::aws:policy/AdministratorAccess",
    "bimpe2" = "arn:aws:iam::aws:policy/AdministratorAccess"
  }
}

locals {
  managed_policies = {
    Security = "arn:aws:iam::aws:policy/AdministratorAccess"
    Dev      = "arn:aws:iam::aws:policy/ReadOnlyAccess"
    Comp     = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  }

  inline_Policies = {
    Security = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {

          "Effect" : "Allow",
          "Action" : ["ec2:*"],
          "Resource" : ["*"]
        }
      ]
    })

    Dev = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {

          "Effect" : "Allow",
          "Action" : ["s3:*"],
          "Resource" : ["*"]
        }
      ]
    })

    Comp = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {

          "Effect" : "Allow",
          "Action" : ["cloudtrail:*"],
          "Resource" : ["*"]
        }
      ]
    })
  }
}
