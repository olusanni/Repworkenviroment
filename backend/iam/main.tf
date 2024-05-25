 
resource "aws_iam_user" "new_user1" {
  for_each = local.Team
  name     = each.key
}

resource "aws_iam_user_policy_attachment" "test-attach1" {
  for_each   = local.Team
  user       = aws_iam_user.new_user1[each.key].name
  policy_arn = each.value
}

resource "aws_iam_group" "my_group" {
  for_each = local.managed_policies
  name     = each.key
}

resource "aws_iam_group_policy_attachment" "group_managed_policy" {
  for_each   = local.managed_policies
  group      = aws_iam_group.my_group[each.key].name
  policy_arn = each.value
}
resource "aws_iam_group_policy" "group_inline_policy" {
  for_each = local.inline_Policies
  name     = "${each.key}-policy"
  group    = aws_iam_group.my_group[each.key].name
  policy   = each.value
}