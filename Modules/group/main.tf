resource "aws_iam_group" "usergroup" {
  name = var.groupname
}

resource "aws_iam_group_policy_attachment" "usergroup_managed_policy" {
    for_each = toset(var.managed_policies_to_attach)
  group      = aws_iam_group.usergroup.name
  policy_arn = each.value
}

resource "aws_iam_policy" "usergroup_inline_policy" {
    count = var.inline_policy_to_attach != "" ? 1 : 0
  name        = var.policy_name
  description = var.policy_description
  policy = var.inline_policy_to_attach
}

resource "aws_iam_group_policy_attachment" "group_managed_policy" {
  count = var.inline_policy_to_attach != "" ? 1 : 0
  group      = aws_iam_group.usergroup.name
  policy_arn = aws_iam_policy.usergroup_inline_policy[0].arn
}